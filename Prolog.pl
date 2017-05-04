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
:- http_handler(root(welcome), katigorima_parousiasi_apotelesmaton, []).
:- http_handler(root(selection),selection,[]).

/*  Το κατηγόρημα checkUserPwd(UserId, PWD) είναι αληθές  εαν  
UserId είναι το όνομα χρήστης και PWD είναι ο κωδικός χρήστη.
mode(g,g)
ΣΤΟΧΟΙ
checkUserPwd(std2, crete).*/
checkUserPwd(UserId, PWD)  :- 
     (UserId = 'std1', PWD=kal);
	 (UserId = 'std2', PWD=crete);
	 (UserId = 'std3', PWD=athens);
	 (UserId = 'tch', PWD=tch).	

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
		format('Content-type: text/html~n~n'),
		current_output(Out),
		st_render_file(views/logIn, _{
			title: 'Prolog Intelligent Tutoring Systems',
			errorMessage: 0
		}, Out, []).
		
katigorima_parousiasi_apotelesmaton(Request):-
http_parameters(Request,[ username(UserId, []),password(PWD, [])]),
		   (checkUserPwd(UserId, PWD),
		  ((UserId=tch,PWD=tch,teacher(UserId));
		   (start_lesson(UserId,PWD)));
		   (format('Content-type: text/html~n~n'),
			current_output(Out),
			st_render_file(views/logIn, _{
			title: 'Prolog Intelligent Tutoring Systems',
			errorMessage: 1
			}, Out, [])
		   )).
	
start_lesson(UserId,PWD) :-
		format('Content-type: text/html~n~n'),
		lessons(UserId,Lesson,LessId,LessonType),
		clause(kb_lesson(LessId,L,Goal_Id),K),
		clause(kb_stoxoi(Goal_Id,Text_G),B),
		current_output(Out),
		st_render_file(views/welcome, _{
			title: 'Prolog Intelligent Tutoring Systems',
			lesson: Lesson,
			targets: Text_G
		}, Out, []).


selection(_Request) :-
		format('Content-type: text/html~n~n'),
		current_output(Out),
		st_render_file(views/pathSelection, _{
			title: 'Prolog Intelligent Tutoring Systems'
		}, Out, []).

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
			
last1(X, [X]).
last1(X, [ Head | Tail] ):- last1(X,Tail).