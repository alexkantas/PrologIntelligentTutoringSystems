:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_error)).
:- use_module(library(http/http_parameters)).
% http_reply_from_files is here
:- use_module(library(http/http_files)).
% http_404 is in here
:- use_module(library(http/http_dispatch)).
% html generation and mailman
:- use_module(library(http/html_write)).
% html_resource
:- use_module(library(http/html_head)).
% module for sessions
:- use_module(library(http/http_session)).

:- use_module(prolog/st/st_parse).
:- use_module(prolog/st/st_render).
:- use_module(prolog/st/st_file).

:- use_module(library(uri)).
:- use_module(library(pairs)).
:- consult('kb_pts.pl').
:- consult('schema_base.pl').

:- multifile http:location/3.
:- dynamic   http:location/3.

http:location(files, '/assets', []).

% this serves files from the directory assets
% under the working directory
:- http_handler(files(.), serve_files, [prefix]).

:- http_handler(root(.),say_hi,[]).
:- http_handler(root(logIn),arxiki_selida_input,[]).
:- http_handler(root(logOut),logout,[]).
:- http_handler(root(welcome), katigorima_parousiasi_apotelesmaton, []).
:- http_handler(root(selection),selection,[]).
:- http_handler(root(review),assessment,[]).
:- http_handler(root(results),results,[]).
:- http_handler(root(complete),assesment_end,[]).
:- http_handler(root(practice),practise,[]).

/*  Το κατηγόρημα checkUserPwd(UserId, PWD) είναι αληθές  εαν  
UserId είναι το όνομα χρήστης και PWD είναι ο κωδικός χρήστη.
mode(g,g)
ΣΤΟΧΟΙ
checkUserPwd(std2, crete).*/
checkUserPwd(UserId, PWD)  :- 
     (UserId = 'std1', PWD=kal);
	 (UserId = 'std2', PWD=crete);
	 (UserId = 'std3', PWD=athens).	

server(Port) :-
        http_server(http_dispatch, [port(Port)]).

serve_files(Request) :-
	 http_reply_from_files('assets', [], Request).
serve_files(Request) :-
	  http_404([], Request).
	  

say_hi(_Request) :-
		format('Content-type: text/html~n~n'),
		current_output(Out),
		st_render_file(views/main, _{
			title: 'Prolog Intelligent Tutoring Systems'
		}, Out, []).

arxiki_selida_input(Request) :-
		logMessage(0).

logout(Request) :-
		logMessage(2).
		
katigorima_parousiasi_apotelesmaton(Request):-
http_parameters(Request,[ username(UserId, []),password(PWD, [])]),
		   (checkUserPwd(UserId, PWD),
		  ((start_lesson(UserId,PWD)));
		   (logMessage(1))).
	
start_lesson(UserId,PWD) :-
		format('Content-type: text/html~n~n'),
		lessons(UserId,Lesson,LessId,LessonType),
		http_session_assert(user_id(UserId)),
		http_session_assert(less_id(LessId)),
		clause(kb_lesson(LessId,L,Goal_Id),K),
		clause(kb_stoxoi(Goal_Id,Text_G),B),
		courseSelection(UserId, LessId, LessonType,NLessId) ,
		clause(kb_lesson(NLessId,[LectureId,PracticeId,AssesmentId],Goal),B),
		http_session_assert(ass_id(AssesmentId)),
		current_output(Out),
		st_render_file(views/welcome, _{
			title: 'Prolog Intelligent Tutoring Systems',
			lesson: Lesson,
			targets: Text_G
		}, Out, []).


selection(_Request) :-
		user_id(UserId),
		format('Content-type: text/html~n~n'),
		current_output(Out),
		st_render_file(views/pathSelection, _{
			title: 'Prolog Intelligent Tutoring Systems'
		}, Out, []).

selection(_Request) :-
	reply_html_page(
	   [title('Πρόβλημα :-(')],
	   [h1('Ουπς! Παρουσιάστηκε κάποιο πρόβλημα!'),
	    a(href='/logIn','Δοκίμασε να ξανασυνδεθείς!')]).
		
practice(_Request) :-
		user_id(UserId),
		format('Content-type: text/html~n~n'),
		current_output(Out),
		st_render_file(views/practiceSelection, _{
			title: 'Prolog Intelligent Tutoring Systems'
		}, Out, []).

practice(_Request) :-
	reply_html_page(
	   [title('Πρόβλημα :-(')],
	   [h1('Ουπς! Παρουσιάστηκε κάποιο πρόβλημα!'),
	    a(href='/logIn','Δοκίμασε να ξανασυνδεθείς!')]).

lessons(UserId,Lesson,LessId,LessonType) :- 
        ((clause(student(UserId,PersDetails),Body1),UserType = old);
		  UserType = new),
		( (UserType = new, LessId = les1, LessonType = new, write(LessId),nl) ;
		  (UserType = old, courseSelection(UserId, LessId,LessonType,NLessId),
		   name(NLessId,LessId_char),
		   LessId_char= [H1,H2,H3|T],
		   name(Lesson,T),nl),
		   assertz(kb_course_stud(UserId,[[LessId,[],[],[]]]))
		 ).
		 
courseSelection(UserId, LessId, LessonType,NLessId) :- 
			clause(kb_course_stud(UserId,Lessons), Body),
			last1(LastLesson,Lessons),
			LastLesson = [PassedLessId,Lect,Pract,[AssId,AssGrade]],
			(	(AssGrade < 5, !, 
				LessId = PassedLessId,
				LessonType = repeat,
				NLessId=LessId);
				(name(PassedLessId,LessChars),
				LessChars = [H1,H2,H3|T],
				name(PassedN,T),
				NewN is PassedN +1,
				name(NewN, NewLessN),
				NewLessChars = [H1,H2,H3|NewLessN],	
				name(NewLessId, NewLessChars),
				LessonType = new,
				NLessId=NewLessId
				)
			).
			
assessment(Request) :-
			less_id(LessId),
			ass_id(AssId),
			clause(kb_lesson_assessment(LessId,AssId,TestId),B1),
			bagof(ExId,kb_test_assessment(TestId,ExId,ExersiceType,AnswerId,Grade)^clause(kb_test_assessment(TestId,ExId,ExersiceType,AnswerId,Grade),B4), L),
			L=[H|G],
			G=[T],
			clause(kb_exersise_assessment(H,Text_exA),B3),
			clause(kb_exersise_assessment(T,Text_exB),B6),
			format('Content-type: text/html~n~n'),
			current_output(Out),
			st_render_file(views/review, _{
			title: 'Prolog Intelligent Tutoring Systems',
			questionA: Text_exA,
			questionB: Text_exB
			}, Out, []).

results(Request):-
	less_id(LessId),
	ass_id(AssId),
	http_parameters(Request,[ans1(Ans1,[]),ans2(Ans2,[])]),
	clause(kb_lesson_assessment(LessId,AssId,TestId),B1),
	bagof(AnswerId,kb_test_assessment(TestId,ExId,ExersiceType,AnswerId,Grade)^clause(kb_test_assessment(TestId,ExId,ExersiceType,AnswerId,Grade),B4), L),
	L=[H|G],
	G=[D|T],
	clause(kb_answer_assessment(H,Text_ans1),B7),
	clause(kb_answer_assessment(D,Text_ans2),B6),
	bagof(Grade,kb_test_assessment(TestId,ExId,ExersiceType,AnswerId,Grade)^clause(kb_test_assessment(TestId,ExId,ExersiceType,AnswerId,Grade),B5), O),
	O=[Grade1|Grad],
	Grad=[Grade2|GrTail],
	 ((Ans1=Text_ans1,New_InitGrade1 is Grade1);New_InitGrade1 is 0),
	  ((Ans2=Text_ans2,New_InitGrade2 is Grade2);New_InitGrade2 is 0),
	 New_InitGrade is New_InitGrade2 + New_InitGrade1,
	 http_session_retractall(total_score(X)),
	 http_session_assert(total_score(New_InitGrade)),
	format('Content-type: text/html~n~n'),
			current_output(Out),
			st_render_file(views/results, _{
			title: 'Prolog Intelligent Tutoring Systems',
			score1: New_InitGrade1,
			score2: New_InitGrade2,
			totalScore: New_InitGrade,
			ans1: Text_ans1,
			ans2: Text_ans2
			}, Out, []).
			
assesment_end(Request):-
	total_score(TotalScore),
	format('Content-type: text/html~n~n'),
			current_output(Out),
			st_render_file(views/complete, _{
			title: 'Prolog Intelligent Tutoring Systems',
			totalScore: TotalScore
			}, Out, []).
	
	
wellDone(Message):-
			format('Content-type: text/html~n~n'),
			current_output(Out),
			st_render_file(views/wellDone, _{
			title: 'Prolog Intelligent Tutoring Systems',
			message: Message
			}, Out, []).
			
logMessage(Message):-
		http_session_retractall(less_id(X)),
		http_session_retractall(ass_id(X)),
		http_session_retractall(user_id(X)),
		http_session_retractall(total_score(X)),
		format('Content-type: text/html~n~n'),
		current_output(Out),
		st_render_file(views/logIn, _{
			title: 'Prolog Intelligent Tutoring Systems',
			errorMessage: Message
		}, Out, []).
			

user_id(UserId) :-
	http_session_data(user_id(UserId)),!.

less_id(LessId) :-
	http_session_data(less_id(LessId)),!.

ass_id(AssId) :-
	http_session_data(ass_id(AssId)),!.
	
total_score(TotalScore):-
	http_session_data(total_score(TotalScore)),!.

last1(X, [X]).
last1(X, [ Head | Tail] ):- last1(X,Tail).