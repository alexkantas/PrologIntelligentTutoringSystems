:-dynamic max_student_id/1, students/1, student/2. 
:-dynamic kb_course_stud/2.
:-dynamic kb_lect_ex/6.
:-dynamic kb_lecture_theory/2.
:-dynamic kb_lect_quest/2.
:-dynamic kb_lect_answer/2.

:- dynamic kb_lesson/3.
:- dynamic kb_lesson_lecture/5.
:- dynamic kb_theory_lecture/2.
:- dynamic kb_exersise_lecture/2.
:- dynamic kb_answer_lecture/2.
:- dynamic kb_lesson_practice/6.
:- dynamic kb_exersise_practice/2.
:- dynamic kb_help_practice/4.
:- dynamic kb_helpText_practice/3.
:- dynamic kb_answer_practice/2.
:- dynamic kb_lesson_assessment/3.
:- dynamic kb_test_assessment/5.
:- dynamic kb_exersise_assessment/2.
:- dynamic kb_answer_assessment/2.
:- dynamic kb_bibliog/2.
:- dynamic kb_helpdesc/2.
:- dynamic kb_title/2.
:- dynamic kb_helpdesc_id/1.
:- dynamic kb_stoxoi/2.

max_student_id(4).
students([stid1,stid2,stid3,stid4]).
% 
% student(Student_Id, [[Onoma,Epitheto],Tmima, AM]).
student(std1,[[afrodity,stathaki], ie, 3797 ]).
student(std2,[[nikos,nikolaou], ie, 9719 ]).
student(std3,[[petros,petrou], ie, 9727 ]).
student(std4,[[manousos,manousakis],eed, 9768 ]).

/* kb_course_stud(Student_Id, [[Lesson_Id, [Lecture_Id,Lect_values], 
  [Practice_Id, Practice_Values], [Assessment_Id, Assessment_Values] ]  ).
  Student_Id: stdN where N > 0, e.g. stid1, stdi2,etc.
  Lesson_Id: lesdN where N >0, e.g. lessid1,lessid2,etc.
  Lecture_Id: lctN, where N > 0, e.g. lectid1, lectid2,etc.
  Practice_Id: praN,  where N > 0, e.g. practid1, practid2, etc.
  Assessment_Id: assN, where N > 0, e.g. assid1, assid2, etc.  
  Lect_values: corr(ect), wr(ong), nil
  Practice_Values: corr(ect), wr(ong), nil
  Assessment_Values: integers in the interval 0-10

  */
kb_course_stud(std1, 
	[ 	[les1, [lct,compl], [pra,comph], [ass,7]],
		[les2, [lct,corr], [pra,nil_p], [ass,6]] ,
		[les3, [lct,nil_l], [pra,comph], [ass,4]]  
	] ).
kb_course_stud(std2, 
	[ 	[les1, [lct,corr], [pra,compp], [ass,3]]
	] ).
kb_course_stud(std3, 
	[ 	[les1, [lct,corr], [pra,nil_p], [ass,3]]
	] ).

%kb_helpdesc(Hd_id,'coments').
%
kb_helpdesc(hd1,'yliko').
kb_helpdesc(hd2,'poly kalo').
kb_helpdesc(hd3,'thelw perissotero yliko').

%kb_helpdesc_id(Hd_id).
kb_helpdesc_id(hd1).
kb_helpdesc_id(hd2).
kb_helpdesc_id(hd3).

%kb_lesson(LessonId,[LectureId,PracticeId,AssesmentId]).
%
kb_lesson(les1,[lct1,pra1,ass1],gol1).
kb_lesson(les2,[lct2,pra2,ass2],gol2).
kb_lesson(les3,[lct3,pra3,ass3],gol3).


%kb_lesson_lecture(LessonId,LectureId,TheoryId,ExId,[TypeEx,AnswerId]).
%
kb_lesson_lecture(les1,lct1,theoryId1,exId1,[full_example,answerId1]).
kb_lesson_lecture(les1,lct1,theoryId2,exId2,[full_example,answerId2]).
kb_lesson_lecture(les2,lct2,theoryId3,exId3,[full_example,answerId3]).
kb_lesson_lecture(les2,lct2,theoryId4,exId4,[full_example,answerId4]).
kb_lesson_lecture(les3,lct3,theoryId5,exId5,[full_example,answerId5]).
kb_lesson_lecture(les3,lct3,theoryId6,exId6,[full_example,answerId6]).

%kb_theory_lecture(TheoryId,'').
%
kb_theory_lecture(theoryId1,'Εισαγωγή: Ένα λογικό πρόγραμμα αποτελείται από προτάσεις γεγονότα,κανόνες και ερωτήσεις. Η πιο απλή πρόταση σε Prolog είναι το γεγονός. Τα γεγονότα είανι ένας τρόπος να εκφραστούν οι σχέσεις που ισχύουν μεταξύ των αντικειμένων. Στον Λογικό προγραμματισμό μια σχέση παριστάνεται με ένα κατηγόρημα και τα αντικείμενα της σχέσης είανι τα ορίσματα.Για παράδειγμα, η σχέση <Ο Γιάννης είναι άντρας της Μαρίας> σε Prolog εκφράζεται: antras(yannis,maria).').
kb_theory_lecture(theoryId2, 'Όροι:Τα δεδομένα στην Prolog ονομάζονται όροι. Υπάρχουν 3 βασικές κατηγορίες όρων: οι μεταβλητές,οι σταθερές και οι σύνθετοι όροι. Οι σταθερές που υποστηρίζονται από τη Prolog είναι τα άτομα,οι αριθμοί και τα ειδικά σύμβολα. Οι μεταβλητές σε Prolog αντιπροσωπεύουν αντικείμενα τα οποία δεν μπορούμε να ονομάσουμε επειδή δεν ξέρουμε ποια αντικείμενα είναι. Οι σύνθετοι όροι είναι ένα αντικείμενο το οποίο αποτελείται από άλλα αντικείμενα που ονομάζονται συστατικά μέρη. Ένας σύνθετος όρος αποτελείται από το όνομα της συνάρτησης και τα ορισματά της. Για παράδειγμα σε μορφή Prolog: ονομα_συναρτησης(ορισμα1,ορισμα2).').
kb_theory_lecture(theoryId3, 'Ενοποίηση: Ένας όρος έχει δεδροειδή δομή. Οι κόμβοι των όρων είναι ονόματα συναρτήσεων των οποίων τα μπορεί να είναι είτε σταθερές ή μεταβλητές ή όροι. Η πιο σπουδαία πράξη μεταξύ δύο ορών είναι η ενοποίηση. Η πράξη της ενοποίησης εξετάζει εάν δύο όροι Τ1 και Τ2 ταιριάζουν δεσμεύοντας μερικές από τις μεταβλητές των δυο όρων Τ1 και Τ2. Παράδειγμα: unify(T1,T2,Theta) , όπου Τ1 και Τ2 είναι οι όροι τους οποίους ενοποιεί  και Theta είναι ένα σύνολο από δεσμεύσεις μεταβλητών των όρων Τ1 και Τ2.').
kb_theory_lecture(theoryId4, 'Προτάσεις Κανόνες: Εάν p είναι ένα σύμβολο κατηγορήματος ν-ορισμάτων και t1-tn είναι όροι, τότε τότε p(t1,...,tn) είναι ένας ατομικός τύπος(atomic formula). Παράδειγμα: pateras(kostas, anna),paidi(kostas,X).  Όλες οι προτάσεις ενός προγράμματος με κεφαλή ίδιο κατηγόρημα και ίδια πληθικότητα αποτελούν μια διαδικασία(procedure) σε Prolog. Ένα Prolog πρόγραμμα αποτελείται από μια συλλογή Prolog διαδικασίες').
kb_theory_lecture(theoryId5, 'Κατασκευή δομή στην κεφαλή μιας πρότασης: Είναι μια προγραμματιστική τεχνική που βοηθά στην κατασκευή προγραμματων σε Prolog. Το αποτέλεσμα αυτής της τεχνικής συσσωρεύεται στην επαγωγική δομή δεδομένων χρησιμοποιώντας τη στοίβα της Prolog. Η επαγωγική δομή που δημιουργείται σε κάθε αναδρομική κλήση είναι ημιτελές και δεν υπάρχει πρόσβαση στο τμήμα που έχει ήδη καταστευαστεί. Ένα τμήμα της αναμένεται να ολοκληρωθεί από την αναδρομική επεξεργασία των υπόλοιπων στοιχείων της επαγωγικής δομής η οποία ελέγχει την αναδρομή. ').
kb_theory_lecture(theoryId6, 'Κατασκευή δομή στην κεφαλή μιας πρότασης: Κατηγόρημα(ΒάσηΔομήςΕλέγχου, ΒάσηΚατασκευαζόμενηςΔομής). Κατηγόρημα(ΔομήΕλέγχου, ΤελικήΚατασκευαζόμενηΔομή):- Κατηγόρημα(ΜικρότερηΔομήΕλέγχου, ΚατασκευαζόμενοΜέροςΔομής), Κατηγόρημα(ΚατασκευαζόμενοΜέροςΔομής, ΤελικήΚατασκευασμένηΔομή).  Παράδειγμα: Σβήσιμο της πρώτης εμφάνισης στοιχείου από λίστα. Δημιουργούμε το κατηγόρημα delete(X,List1,List2) για να σβήσουμε το στοιχείο  X απο τη τη List1, δημιουργώντας τη List2. Αρχικά διακρίνουμε περιπτώσεις : Πρώτη Περίπτωση:Το στοιχείο Χ που θέλουμε είναι η κεφαλή της λίστας. Δεύτερη Περίπτωση: Το στοιχείο Χ που θέλουμε είναι η ουρά της λίστας. Άρα delete(X,[X|Tail1],Tail1). delete(X,[Y|Tail1],[Y|Tail2]):-delete(X,Tail1,Tail2). ').

%kb_exersise_lecture(ExId,'').
%
kb_exersise_lecture(exId1,'Να παραστήσεται σε Prolog τη σχέση <Ο Γιάννης είναι πατέρας του Κώστα>.').
kb_exersise_lecture(exId2,'Να παραστήσεται τη σχέση <Η Άννα είναι μητέρα της Μαρίας>.').
kb_exersise_lecture(exId3,'Έστω οι όροι Τ1: antras(yannis,X) και Τ2: antras(Y,maria) . Οι δύο παραπάνω όροι ενοποιούνται?ΣΩΣΤΟ ή ΛΑΘΟΣ').
kb_exersise_lecture(exId4,'Μια διαδικασία(procedure) σε Prolog αποτελείται από πολλές προτασεις, και οι πολλές διαδικασίες αποτελούν ένα πρόγραμμα.ΣΩΣΤΟ ή ΛΑΘΟΣ').
kb_exersise_lecture(exId5,'Το αποτέλεσμα στη τεχνική "κατασκευής δομής στην κεφαλή μιας πρότασης" συσσωρεύεται στην επαγωγική δομή χρησιμοποιώντας την στοίβα της Prolog. ΣΩΣΤΟ ή ΛΑΘΟΣ ').
kb_exersise_lecture(exId6,'Δημιουργείστε την κλήση του κατηγορήματος delete για να σβήσετε το στοιχείο a από τη λίστα [a,b,a,c] δημιουργώντας τη τελική λίστα L2.').

							 
%kb_answer_lecture(AnswerId,'').
%
kb_answer_lecture(answerId1,'pateras(yannis,kostas).').
kb_answer_lecture(answerId2,'mitera(anna,maria).').
kb_answer_lecture(answerId3,'ΝΑΙ').
kb_answer_lecture(answerId4,'ΣΩΣΤΟ').
kb_answer_lecture(answerId5,'ΣΩΣΤΟ').
kb_answer_lecture(answerId6,'delete(a,[a,b,a,c],L2).').

%kb_stoxoi(Goal_Id,'').
kb_stoxoi(gol1,"<ol><li>Να κατανοήσουν τα βασικά μέρη ενός προγράμματος Prolog και</li><li>Να μπορούν να συντάξουν τους όρους της Prolog σε κανόνες παραγωγής.</li><ol>").
kb_stoxoi(gol2,'<ol><li>Να κατανοήσουν την έννοια της Ενοποίησης και</li><li>Να μπορούν να δημιουργήσουν σύνθετες προτάσεις και ερωτήσεις.</li></ol>').
kb_stoxoi(gol3,'<ol><li>Να κατανοήσουν την τεχνική κατασκευής δομής στην κεφαλή μια πρότασης στην Prolog και</li><li>Να μπορούν να συντάξουν πραγράμματα και με αυτή την τεχνική.</li></ol>').



%kb_lesson_practice(LessonId,PracticeId,TypePractice,PracticeExId,HelpId,AnswerId,BibId).
%
kb_lesson_practice(les1,pra1,s_b_s,practiceExId1,helpId1,answerId1,bib1).
kb_lesson_practice(les2,pra2,s_b_s,practiceExId2,helpId2,answerId2,bib1).
kb_lesson_practice(les3,pra3,s_b_s,practiceExId3,helpId3,answerId3,bib1).

%kb_bibliog(BibId,'link').
kb_bibliog(bib1,'www.prolog.com').

%kb_exersise_practice(PracticeExId,'').
%
kb_exersise_practice(practiceExId1,'Σας δίνεται η παρακάτω βάση γνώσης. ?-pateras(kostas,anna).  ?-mitera(maria,anna). ?-mitera(maria,ari).   ?-pateras(kostas,ari). Δημιουργήστε τις ερωτήσεις <Ο Άρης είναι πατέρας του Κώστα?>.').
kb_exersise_practice(practiceExId2,'Σας δίνεται η παρακάτω βάση γνώσης.
goneas(aris, anna).
goneas(maria1, anna).
goneas(yannis, maria2).
goneas(yannis, kostas).
goneas(yannis, manolis).
goneas(anna, maria2).
goneas(anna, kostas).
goneas(anna, manolis).
filo_arseniko(yannis).
filo_arseniko(kostas).
filo_arseniko(manolis).
filo_arseniko(panos).
filo_arseniko(aris).
filo_thiliko(maria1).
filo_thiliko(maria2).
filo_thiliko(anna).
filo_thiliko(eleni).
adelfi(anna,aris). Να δημιουργήσεις τον κανόνα adelfos/2.').
kb_exersise_practice(practiceExId3,'Να φτιάξετε ένα κατηγόρημα deleteAll το οπίο θα σβήνει όλες τις εμφανίσεις των στοιχείων X από τη λίστα List1,δημιουργώντας τη λίστα List2. Στο πεδίο της απάντησης δώσε τη δεύτερη περίπτωση σύμφωνα με το σχήμα.').

%kb_help_practice(HelpId,Help_Level1_Id,Help_Level2_Id,Help_Level3_Id).
%
kb_help_practice(helpId1,Help_Level1_Id1,Help_Level2_Id1,Help_Level3_Id1).
kb_help_practice(helpId2,Help_Level1_Id2,Help_Level2_Id2,Help_Level3_Id2).
kb_help_practice(helpId3,Help_Level1_Id3,Help_Level2_Id3,Help_Level3_Id3).

%kb_helpText_practice(HelpId,Help_Level1_Id,'').
%
kb_helpText_practice(helpId1,help_Level1_Id1,'Για να κάνουμε μια ερώτηση στην Prolog χρησιμοποιούμε το σύμβολο <?->').
kb_helpText_practice(helpId1,help_Level2_Id1,'Το σώμα της ερώτησης αποτελείται από το κατηγόρημα(τη σχέση) και τα ορίσματα(τα ονόματα).').
kb_helpText_practice(helpId1,help_Level3_Id1,'Για την πρώτη ερώτηση το κατηγόρημα είναι pateras και τα ορίσματα είναι aris,kostas').
kb_helpText_practice(helpId2,help_Level1_Id2,'Για να δημιουργήσεις τη σχέση adelfos χρειάζεσαι τη σχέση adelfi,filo_arseniko και filo_thiliko').
kb_helpText_practice(helpId2,help_Level2_Id2,'Για να ξεκινήσεις, ορίζεις adelfos(Χ,Υ) και μετά τα σύμβολα :- δημιουργείς τις προυποθέσεις.').
kb_helpText_practice(helpId2,help_Level3_Id2,'Η σχέση adelfos(Χ,Υ) είναι αληθής εάν η Υ είναι αδελφή του Χ . Ο Χ είναι φύλλο αρσενικό και ο Υ είναι θηλυκό.').
kb_helpText_practice(helpId3,help_Level1_Id3,'Βασική περίπτωση είναι όταν List1 είναι άδεια.').
kb_helpText_practice(helpId3,help_Level2_Id3,'Γενική περίπτωση 1: Το στοιχείο X είναι η κεφαλή της λίστας List1.').
kb_helpText_practice(helpId3,help_Level3_Id3,'Γενική περίπτωση 2: Το στοιχείο X είναι κάποιο στοιχείο της ουράς της λίστας List1.').

%kb_answer_practice(AnswerId,'').
%
kb_answer_practice(answerId1,'?-pateras(aris,kostas).').
kb_answer_practice(answerId2,'adelfos(X,Y):-adelfi(Y,X),filo_arseniko(X),filo_thiliko(Y).').
kb_answer_practice(answerId3,'deleteAll(X,[X|Tail1],List2):-deleteAll(X,Tail1,List2).').

%kb_lesson_assessment(LessonId,AssesmentId,[TestId1,TestId2]).
%
kb_lesson_assessment(les1,ass1,testId1).
kb_lesson_assessment(les2,ass2,testId2).
kb_lesson_assessment(les3,ass3,testId3).

%kb_test_assessment(TestId,ExId,ExersiceType,AnswerId,Grade).
%
kb_test_assessment(testId1,exId1,full_example,answerId1,4).
kb_test_assessment(testId1,exId2,full_example,answerId2,6).
kb_test_assessment(testId2,exId3,full_example,answerId3,4).
kb_test_assessment(testId2,exId4,full_example,answerId4,6).
kb_test_assessment(testId3,exId5,full_example,answerId5,4).
kb_test_assessment(testId3,exId6,full_example,answerId6,6).

%kb_exersise_assessment(ExId,'text').
%
kb_exersise_assessment(exId1,'Δημιουργησε τη σχεση στην Prolog ο Γιάννης είναι αδερφος του Κώστα').
kb_exersise_assessment(exId2,'Να παραστήσετε σαν ένα σύνθετο όρο της Prolog την εκπαιδευτική οργάνωση ενός  Ανώτατου Εκπαιδευτικού Ιδρύματος (ΑΕΙ). Να θεωρήσετε ότι ένα ΑΕΙ αποτελείται από σχολές,  κάθε σχολή αποτελείται από τμήματα και κάθε τμήμα αποτελείται από κατευθύνσεις. Να γράψετε ένα στιγμιότυπο του σύνθετου όρου που κάνατε που να  αφορά το ίδρυμα, τη σχολή, το τμήμα και την κατεύθυνση που είστε.Οι όροι που πρέπει να χρησιμοποιήσετε είναι spoudastis_TEI_Crete,dieuthinsi,spoudazi').							   
kb_exersise_assessment(exId3,'Οι σχέσεις adelfos/2 και adelfi/2 έχουν την εξής σημασία. a. adelfos(X, Y) σημαίνει ότι ο Χ είναι αδελφός του Υ. b. adelfi(X, Y) σημαίνει ότι η Χ είναι αδελφή του Υ. Δίνεται ή ακόλουθη βάση γνώσης adelfos(yannis, kostas). adelfos(yannis, manolis). adelfos(kostas, manolis). adelfi(maria, kostas). adelfi(anna, kostas).  Θεωρώντας ότι κάθε όνομα αναφέρεται στο ίδιο πρόσωπο κάνε ερώτηση οι οποία να βρίσκει τα εξής:  Ποια είναι τα αδελφια του kostas. ').
kb_exersise_assessment(exId4,'Οι σχέσεις adelfos/2 και adelfi/2 έχουν την εξής σημασία. a. adelfos(X, Y) σημαίνει ότι ο Χ είναι αδελφός του Υ. b. adelfi(X, Y) σημαίνει ότι η Χ είναι αδελφή του Υ. Δίνεται ή ακόλουθη βάση γνώσης adelfos(yannis, kostas). adelfos(yannis, manolis). adelfos(kostas, manolis). adelfi(maria, kostas). adelfi(anna, kostas).  Θεωρώντας ότι κάθε όνομα αναφέρεται στο ίδιο πρόσωπο κάνε ερώτηση οι οποία να βρίσκει τα εξής:  Ποιοι είναι τα αδελφοί του kostas. ').
kb_exersise_assessment(exId5,'Γράψετε κατηγόρημα occurrences(L, X, N) το οποίο είναι αληθές εάν Ν είναι το πλήθος των επαναλήψεων του στοιχείου Χ στην λίστα L.Η υλοποίηση να γίνει με την τεχνική κατασκευής δομής στη κεφαλή της πρότασης.').
kb_exersise_assessment(exId6,'Γράψετε κατηγόρημα unique(St, Lista) το οποίο επιστρέφει true εάν το στοιχείο St υπάρχει μόνο μια φορά στην λίστα Lista. Μπορείτε να χρησιμοποιήσετε το κατηγόρημα member/2.').

%kb_answer_assessment(AnswerId,'Text').
%
kb_answer_assessment(answerId1,adelfos(yannis,kostas)).
kb_answer_assessment(answerId2,'apadisi').
kb_answer_assessment(answerId3,'apadisi').
kb_answer_assessment(answerId4,'apadisi').
kb_answer_assessment(answerId5,'occurrences(L, X, N).').
kb_answer_assessment(answerId6,'unique(St, Lista)').


