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

:- use_module(library(http/http_json)).

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
:- http_handler(root(practiceSbS),practise_sbs,[]).
:- http_handler(root(practiseSchema),practise_schema,[]).
:- http_handler(root(practiseSchemaShow),practise_schema_prnt,[]).
:- http_handler(root(practisePrl),practise_prl,[]).
:- http_handler(root(practiceAnswer),pr_answer_page,[]).
:- http_handler(root(practiseComplete),practise_end,[]).
:- http_handler(root(lecture),lecture,[]).
:- http_handler(root(lectureAns),lect_answer,[]).
:- http_handler(root(lectureRes),lect_answer_page,[]).
:- http_handler(root(lectureCo),lectureCo,[]).
:- http_handler(root(teacher),teacher,[]).
:- http_handler(root(showUsers),show_user,[]).
:- http_handler(root(showUsersInfo),captureInfo,[]).
:- http_handler(root(showUserInfo),code,[]).
:- http_handler(root(showInfo),info_pts,[]).
:- http_handler(root(showFeedback),helpdesc,[]).
:- http_handler(root(feedbackData),feedbackData,[]).

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

:-http_server(http_dispatch, [port(80)]).

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
		   ((UserId=tch,PWD=tch,http_session_assert(user_id(UserId)),teacher(UserId));
		  (start_lesson(UserId,PWD)));
		   (logMessage(1))).
		   
teacher(Request) :-
		user_id(UserId),
		((UserId='tch',
		format('Content-type: text/html~n~n'),
		current_output(Out),
		st_render_file(views/teacherHome, _{
			title: 'Prolog Intelligent Tutoring Systems'
		}, Out, [])
		);
		(
		fail
		)).
		
teacher(Request) :-
	failure(Request).

show_user(Request) :-
		user_id(UserId),
		((UserId='tch',
		clause(max_student_id(Number),Cilist),
		bagof([Student_Id,[[Onoma,Epitheto],Tmima, AM]],clause(student(Student_Id, [[Onoma,Epitheto],Tmima, AM]),C1),L2),
		 L2=[A,B,C|D],
		 A=[Code1,[[On1,Ep1],Tm1,Id_am1]],
		 B=[Code2,[[On2,Ep2],Tm2,Id_am2]],
		 C=[Code3,[[On3,Ep3],Tm3,Id_am3]],
		 D=[[Code4,[[On4,Ep4],Tm4,Id_am4]]],
		format('Content-type: text/html~n~n'),
		current_output(Out),
		st_render_file(views/teacherUsers, _{
			title: 'Prolog Intelligent Tutoring Systems',
			totalUsers: Number,
			users: [
			_{ name: On1, lastName: Ep1, code: Code1, department: Tm1, am: Id_am1},
			_{ name: On2, lastName: Ep2, code: Code2, department: Tm2, am: Id_am2},
			_{ name: On3, lastName: Ep3, code: Code3, department: Tm3, am: Id_am3},
			_{ name: On4, lastName: Ep4, code: Code4, department: Tm4, am: Id_am4}
		]
		}, Out, [])
		);
		(
		format('Content-type: text/html~n~n'),
		format('Is ~p',[UserId])
		)).
		
show_user(Request) :-
	failure(Request).
	
captureInfo(Request) :-
		user_id(UserId),
		((UserId='tch',
		bagof([Student_Id,[[Onoma,Epitheto],Tmima, AM]],clause(student(Student_Id, [[Onoma,Epitheto],Tmima, AM]),C1),L2),
		 L2=[A,B,C|D],
		 A=[Code1,[[On1,Ep1],Tm1,Id_am1]],
		 B=[Code2,[[On2,Ep2],Tm2,Id_am2]],
		 C=[Code3,[[On3,Ep3],Tm3,Id_am3]],
		 D=[[Code4,[[On4,Ep4],Tm4,Id_am4]]],
		format('Content-type: text/html~n~n'),
		current_output(Out),
		st_render_file(views/teacherUsersProgress, _{
			title: 'Prolog Intelligent Tutoring Systems',
			users: [
			_{ name: On1, lastName: Ep1, code: Code1, department: Tm1, am: Id_am1},
			_{ name: On2, lastName: Ep2, code: Code2, department: Tm2, am: Id_am2},
			_{ name: On3, lastName: Ep3, code: Code3, department: Tm3, am: Id_am3},
			_{ name: On4, lastName: Ep4, code: Code4, department: Tm4, am: Id_am4}
		]
		}, Out, [])
		);
		(
		fail
		)).
		
captureInfo(Request) :-
	failure(Request).
	
code(Request) :-
		user_id(UserId),
		((UserId='tch',
		http_parameters(Request,[user(Epil,[])]),
		clause(kb_course_stud(Epil,Linfo),Binfo),
		last(Linfo,LastInfo),
		LastInfo = [Lesson_Id, [Lecture_Id,Lect_values],[Practice_Id, Practice_Values],
            	[Assessment_Id, Assessment_Values] ],
		format('Content-type: text/html~n~n'),
		current_output(Out),
		st_render_file(views/teacherInfoUser, _{
			title: 'Prolog Intelligent Tutoring Systems',
			code: Epil,
			lesson: Lesson_Id,
			lectureProgress: Lect_values,
			practiceProgress: Practice_Values,
			reviewProgress: Assessment_Values
		}, Out, [])
		);
		(
		fail
		)).
		
code(Request) :-
	failure(Request).

info_pts(Request) :-
		user_id(UserId),
		((UserId='tch',
		bagof(Linfo, Student_Id^kb_course_stud(Student_Id,Linfo),L),
		flatten1(L,L1),countPract(L1,X),
		clause(max_student_id(N),V),
		NN is N -1,
		countLect(L1,Y),
		format('Content-type: text/html~n~n'),
		current_output(Out),
		st_render_file(views/teacherInfo, _{
			title: 'Prolog Intelligent Tutoring Systems',
			totalUsers: NN,
			practiceCount: X,
			lecturesCount: Y
		}, Out, [])
		);
		(
		fail
		)).
		
info_pts(Request) :-
	failure(Request).
	
	
feedbackData(Request) :-
		user_id(UserId),
		((UserId='tch',
		bagof(Text_hd,Hd_id^clause(kb_helpdesc(Hd_id,Text_hd),B),M),
		reply_json(M)
		);
		(
		reply_json("{{Παρουσιάστηκε κάποιο Πρόβλημα}}")
		)).	
		
helpdesc(Request) :-
		user_id(UserId),
		((UserId='tch',
		format('Content-type: text/html~n~n'),
		current_output(Out),
		st_render_file(views/teacherComments, _{
			title: 'Prolog Intelligent Tutoring Systems',
			comments: "[yliko,poly kalo,thelw perissotero yliko]"
		}, Out, [])
		);
		(
		fail
		)).
		
helpdesc(Request) :-
	failure(Request).
	
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
		courseSelection(UserId, LessId, LessonType,NLessId) ,
		clause(kb_lesson(NLessId,[LectureId,PracticeId,AssesmentId],Goal),B),
		http_session_assert(practice_id(PracticeId)),
		http_session_assert(goal(Goal)),
		http_session_assert(theory('theory1')),
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
		
practise(_Request) :-
		less_id(LessId),
		practice_id(PraId),
		clause(kb_lesson_practice(LessId,PraId,TypePractice,Pra_ExId,HelpId,AnsId,BibId),B1),
		clause(kb_exersise_practice(Pra_ExId,Text_pr_ex),B2),
		format('Content-type: text/html~n~n'),
		current_output(Out),
		st_render_file(views/practiceSelection, _{
			title: 'Prolog Intelligent Tutoring Systems',
			question: Text_pr_ex
		}, Out, []).

practise(_Request) :-
	failure(_Request).
		
		
practise_sbs(Request):-
		less_id(LessId),
		practice_id(PraId),
		clause(kb_lesson_practice(LessId,PraId,TypePractice,Pra_ExId,HelpId,AnsId,BibId),B1),
		 clause(kb_exersise_practice(Pra_ExId,Text_pr_ex),B2),
		 clause(kb_help_practice(HelpId,Help_Level1_Id,Help_Level2_Id,Help_Level3_Id),B3),
		 setof(Help_Level1_Id, Text_help1^clause(kb_helpText_practice(HelpId,Help_Level1_Id,Text_help1),B4), L),
		 L = [Help_Level1_Id, Help_Level2_Id, Help_Level3_Id],
		 clause(kb_helpText_practice(HelpId,Help_Level1_Id,Text_help1),B5),	
		 clause(kb_helpText_practice(HelpId,Help_Level2_Id,Text_help2),B6),	
		 clause(kb_helpText_practice(HelpId,Help_Level3_Id,Text_help3),B7),
		 clause(kb_answer_practice(AnsId,Text_ans),B7), 
		format('Content-type: text/html~n~n'),
		current_output(Out),
		st_render_file(views/practiceHelp, _{
			title: 'Prolog Intelligent Tutoring Systems',
			question: Text_pr_ex,
			help1: Text_help1,
			help2: Text_help2,
			help3: Text_help3
		}, Out, []).
		
practise_schema(Request):-
		less_id(LessId),
		practice_id(PraId),
		clause(kb_lesson_practice(LessId,PraId,TypePractice,Pra_ExId,HelpId,AnsId,BibId),B1),
		clause(kb_exersise_practice(Pra_ExId,Text_pr_ex),B2),
		format('Content-type: text/html~n~n'),
		current_output(Out),
		st_render_file(views/practiceSchemaSelect, _{
			title: 'Prolog Intelligent Tutoring Systems',
			question: Text_pr_ex
		}, Out, []).
		
practise_schema_prnt(Request):-
	less_id(LessId),
	practice_id(PraId),
	http_parameters(Request,[value(Value,[])]),
	clause(kb_lesson_practice(LessId,PraId,TypePractice,Pra_ExId,HelpId,AnsId,BibId),B1),
	clause(kb_exersise_practice(Pra_ExId,Text_pr_ex),B2),
	consult('schema_base.pl'),
	schema(Value,L),
	format('Content-type: text/html~n~n'),
		current_output(Out),
		st_render_file(views/practiceSchema, _{
			title: 'Prolog Intelligent Tutoring Systems',
			question: Text_pr_ex,
			schema: L
		}, Out, []).
		
practise_prl(Request):-
		less_id(LessId),
		practice_id(PraId),
		clause(kb_lesson_practice(LessId,PraId,TypePractice,Pra_ExId,HelpId,AnsId,BibId),B1),
		clause(kb_exersise_practice(Pra_ExId,Text_pr_ex),B2),
		format('Content-type: text/html~n~n'),
		current_output(Out),
		st_render_file(views/practiceNoHelp, _{
			title: 'Prolog Intelligent Tutoring Systems',
			question: Text_pr_ex
		}, Out, []).
		
pr_answer_page(Request):-
	less_id(LessId),
	practice_id(PraId),
	http_parameters(Request,[ ans(Ans_ex,[])]),
	clause(kb_lesson_practice(LessId,PraId,TypePractice,Pra_ExId,HelpId,AnsId,BibId),B1),
	clause(kb_answer_practice(AnsId,Text_ans),B7),
	(Ans_ex=Text_ans,wellDone("/practiseComplete"),Complete=yes;niceTry("/practiseComplete",Text_ans)).
	
practise_end(Request) :-
	success("Πρακτική").
	
lecture(Request) :-
	less_id(LessId),
	goal(Goal),
	theory(Theory),
	setof([ThId,ExId,AnsId], kb_lesson_lecture(LessId,LctId,ThId,ExId,[TypeEx,AnsId])^kb_lesson_lecture(LessId,LctId,ThId,ExId,[TypeEx,AnsId]),
             AllThIdsList),
	L_ex=ExId,
	setof(ThId, kb_lesson_lecture(LessId,LctId,ThId,ExId,[TypeEx,AnsId])^kb_lesson_lecture(LessId,LctId,ThId,ExId,[TypeEx,AnsId]),AllThId),
	setof(ExId, kb_lesson_lecture(LessId,LctId,ThId,ExId,[TypeEx,AnsId])^kb_lesson_lecture(LessId,LctId,ThId,ExId,[TypeEx,AnsId]),A),
	setof(AnsId, kb_lesson_lecture(LessId,LctId,ThId,ExId,[TypeEx,AnsId])^kb_lesson_lecture(LessId,LctId,ThId,ExId,[TypeEx,AnsId]),C),
	AllThId=[ThId1|ThId2],
	ThId2=[H],
	A=[ExId1|ExId2],
	ExId2=[E],
	C=[AnsId1|AnsId2],
	AnsId2=[T],
	clause(kb_lesson_lecture(LessId,LctId,ThId,ExId,[TypeEx,AnsId]),V), 
	clause(kb_theory_lecture(ThId1,Text1),B1),
	clause(kb_theory_lecture(H,Text2),B5),
	clause(kb_exersise_lecture(ExId,Text_ex),B2),
	clause(kb_answer_lecture(AnsId,Text_ans),K),
	clause(kb_stoxoi(Goal,G_Text),O),
	http_session_retractall(ex_id(X)),
	http_session_assert(ex_id(ExId)),
	http_session_retractall(ex_id2(X)),
	http_session_assert(ex_id2(E)),
	http_session_retractall(ans_id(X)),
	http_session_assert(ans_id(AnsId)),
	http_session_retractall(ans_id2(X)),
	http_session_assert(ans_id2(T)),
	format('Content-type: text/html~n~n'),
			current_output(Out),
			st_render_file(views/lecture, _{
			title: 'Prolog Intelligent Tutoring Systems',
			goal: G_Text,
			lesson: LessId,
			theoryText1: Text1,
			theoryText2: Text2,
			theory: Theory
			}, Out, []).
			
lect_answer(Request) :-
		theory(Theory),
		ex_id(ExId),
		ex_id2(ExId2),
		((Theory='theory2',
		clause(kb_exersise_lecture(ExId2,Text_ex),B2),
		format('Content-type: text/html~n~n'),
		current_output(Out),
			st_render_file(views/lectureAns, _{
			title: 'Prolog Intelligent Tutoring Systems',
			question: Text_ex
			}, Out, []));
		(clause(kb_exersise_lecture(ExId,Text_ex),B2),
		format('Content-type: text/html~n~n'),
		current_output(Out),
			st_render_file(views/lectureAns, _{
			title: 'Prolog Intelligent Tutoring Systems',
			question: Text_ex
			}, Out, []))).	
			
lect_answer_page(Request) :-
	http_parameters(Request,[ ans(Ans_ex,[])]),
	theory(Theory),
	ans_id(AnsId),
	ans_id2(AnsId2),
	((Theory='theory2',
		clause(kb_answer_lecture(AnsId2,Text_ans),K),
		((Ans_ex=Text_ans,
		wellDone("/lectureCo"),
		Cor_Ans is 1,
		New_corr_ans= Cor_Ans +1);
		(niceTry("/lectureCo",Text_ans)))
		);
		(
		clause(kb_answer_lecture(AnsId,Text_ans),K),
		((Ans_ex=Text_ans,
		wellDone("/lectureCo"),
		Cor_Ans is 1,
		New_corr_ans= Cor_Ans +1);
		(niceTry("/lectureCo",Text_ans)))
		)).
		
		
lectureCo(Request) :-
	theory(Theory),
	((Theory='theory2',
		http_session_retractall(theory(X)),
		http_session_assert(theory('theory1')),
		success("Εισήγηση"));
		(http_session_retractall(theory(X)),
		http_session_assert(theory('theory2')),
		lecture(Request))).


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

/*
Βάζει όλεσ τις λίστες μέσα σε μία
flatten1([a,b,[h,[c,d]],n],L).
*/
flatten1([],[]).
flatten1([H|T],L3):- flatten1(H,L1),flatten1(T,L2),append(L1,L2,L3).
flatten1(A,[A]).


/*
Μετράει πόσες φορές βρέθηκε ένα το pra,και το χρησιμοποιούμε για να δούμε πόσοι χρήστες έκαναν εξάσκηση.
countPract([pra,ass,lect,pra],X).
*/
countPract(L,X):- countPract(L,0,X).
countPract([],An,An).
countPract([H|T],An,I):- H == pra,An1 is An +1, countPract(T,An1,I).
countPract([H|T],An,I):- H \= pra,countPract(T,An,I).

/*
Μετράει πόσες φορές βρέθηκε ένα το lct,και το χρησιμοποιούμε για να δούμε πόσοι χρήστες έκαναν τη θεωρία.
countLect([lct,ass,lct,pra],X).
*/
countLect(L,X):- countLect(L,0,X).
countLect([],An,An).
countLect([H|T],An,I):- H == lct,An1 is An +1, countLect(T,An1,I).
countLect([H|T],An,I):- H \= lct,countLect(T,An,I).
	
wellDone(NextPage):-
			format('Content-type: text/html~n~n'),
			current_output(Out),
			st_render_file(views/wellDone, _{
			title: 'Prolog Intelligent Tutoring Systems',
			nextPage: NextPage
			}, Out, []).
			
niceTry(NextPage,Answer):-
			format('Content-type: text/html~n~n'),
			current_output(Out),
			st_render_file(views/niceTry, _{
			title: 'Prolog Intelligent Tutoring Systems',
			answer: Answer,
			nextPage: NextPage
			}, Out, []).
			
success(Name):-
			format('Content-type: text/html~n~n'),
			current_output(Out),
			st_render_file(views/success, _{
			title: 'Prolog Intelligent Tutoring Systems',
			name: Name
			}, Out, []).
			
logMessage(Message):-
		http_session_retractall(user_id(X)),
		http_session_retractall(less_id(X)),
		http_session_retractall(ass_id(X)),
		http_session_retractall(practice_id(X)),
		http_session_retractall(total_score(X)),
		http_session_retractall(theory(X)),
		http_session_retractall(ex_id(X)),
		http_session_retractall(ex_id2(X)),
		http_session_retractall(ans_id(X)),
		http_session_retractall(ans_id2(X)),
		format('Content-type: text/html~n~n'),
		current_output(Out),
		st_render_file(views/logIn, _{
			title: 'Prolog Intelligent Tutoring Systems',
			errorMessage: Message
		}, Out, []).
		
failure(Request) :-
	reply_html_page(
	   [title('Πρόβλημα :-(')],
	   [h1('Ουπς! Παρουσιάστηκε κάποιο πρόβλημα!'),
	    a(href='/logIn','Δοκίμασε να ξανασυνδεθείς!')]).
			

user_id(UserId) :-
	http_session_data(user_id(UserId)),!.

less_id(LessId) :-
	http_session_data(less_id(LessId)),!.

ass_id(AssId) :-
	http_session_data(ass_id(AssId)),!.
	
practice_id(PraId) :-
	http_session_data(practice_id(PraId)),!.
	
total_score(TotalScore):-
	http_session_data(total_score(TotalScore)),!.
	
theory(Theory):-
	http_session_data(theory(Theory)),!.
	
goal(Goal):-
	http_session_data(goal(Goal)),!.
	
ex_id(ExId):-
	http_session_data(ex_id(ExId)),!.
	
ex_id2(ExId2):-
	http_session_data(ex_id2(ExId2)),!.
	
ans_id(AnsId):-
	http_session_data(ans_id(AnsId)),!.

ans_id2(AnsId2):-
	http_session_data(ans_id2(AnsId2)),!.

last1(X, [X]).
last1(X, [ Head | Tail] ):- last1(X,Tail).