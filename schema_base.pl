﻿:- dynamic schema/2, schemata/1, schema_base_number/1.

/*
Εδώ βρίσκονται τα σχήματα που θα χρησιμοποιηθούν απο τον χρήστη,
σε ground μορφή.
*/



metonomasia(Pr, Lvar,Lpred,Ltuple,test_program,20,20,20).

schemata([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26]).

schema_base_number(26).


% SCHEMATA 1-3 . 
% ΣΧΗΜΑΤΑ ΠΟΥ ΑΦΟΡΟΥΝ ΤΗΝ ΥΠΑΡΞΗ ΜΙΑΣ Ή ΚΑΙ ΠΕΡΙΣΣΟΤΕΡΩΝ
% ΙΔΙΟΤΗΤΩΝ ΣΕ ΕΝΑ ΤΟΥΛΑΧΙΣΤΟΝ ΕΚ ΤΩΝ ΣΤΟΙΧΕΙΩΝ ΜΙΑΣ ΛΙΣΤΑΣ.



% schema_1
% Έλεγχος ύπαρξης μιας ιδιότητας σε κάποιο στοιχείο μιας λίστας.


schema(t1,'<b>Κατηγόρημα  (<k style="color:blue;">ΒάσηΔομήςΕλέγχου</k>, <br> <m style="color:red;"> <x style="color:white;">____________</x>ΒάσηΚατασκευαζόμενηςΔομής</m>). Κατηγόρημα (<k style="color:blue;">ΔομήΕλέγχου</k>,<br><m style="color:#00FF00;"> <x style="color:white;">____________</x>ΤελικήΚατασκευαζόμενηΔομή</m>):-  <u>Κατηγόρημα </u>(<k style="color:blue;">ΜικρότερηΔομήΕλέγχου</k>,<m style="color:red;"> <x style="color:white;">____________</x> ΚατασκευαζόμενοΜέροςΔομής</m>), <u>Κατηγόρημα </u>(<k style="color:red;">ΚατασκευαζόμενοΜέροςΔομής</k>,<m style="color:#00FF00;"> <x style="color:white;">____________</x> ΤελικήΚατασκευασμένηΔομή)</m>.</b>').



% schema_2
% Έλεγχος ύπαρξης μίας εκ' δύο ιδιοτήτων σε κάποιο από τα στοιχεία μιας λίστας.

schema(t2,'<b>Κατηγόρημα(<k style="color:blue;">ΔομήΕλέγχου,ΤελικήΚατασκευασμενηΔομής</k>) :- <br> <x style="color:white;">___</x><u>ΝέοΚατηγόρημα</u>(<k style="color:blue;">ΔομήΕλέγχου</k>,<k style="color:red;">ΒάσηΚατασκευαζόμενηςΔομής</k>,<br><x style="color:white;">____________________________</x><k style="color:#00FF00;">ΤελικήΚατασκευαζόμενηΔομή</k>). ΝέοΚατηγόρημα(<k style="color:blue;">ΒάσηΔομήΕλέγχου</k>,<k style="color:red;">ΚατασκευαζόμενοΜέροςΔομής  </k><x style="color:white;">__________________________</x> ,<k style="color:#00FF00;">ΤελικήΚατασκευασμένηΔομή</k>):- <br><u>Κατασκευή</u> (<k style="color:red;">ΚατασκευαζόμενοΜέροςΔομής, </k><k style="color:magenta;"><x style="color:white;">___________</x>ΝεοΚατασκευαζόμενοΜέροςΔομής</x></k>),<br> <u>ΝέοΚατηγορημα</u>(<m style="color:blue;">ΜικροτερηΔομήΕλέγχου</m>,<m style="color:magenta;"> <x style="color:white;">______________</x>ΝεοΚατασκευαζόμενοΜέροςΔομής</m>,<m style="color:#00FF00;"> <x style="color:white;">______________</x>ΤελικήΚατασκευασμένηΔομή)</m>.</b>').



% schema_3
% Έλεγχος ύπαρξης μίας εκ' τριών ιδιοτήτων σε κάποιο από τα στοιχεία μιας λίστας.

schema(t3,
       [
         [ [pv(1),tuple(1),[cons,v(1),v(2)]],
           [pv(2),tuple(2),v(1)]
         ],
         [ [pv(1),tuple(3),[cons,v(1),v(2)]],
           [pv(3),tuple(4),v(1)]
         ],
         [ [pv(1),tuple(5),[cons,v(1),v(2)]],
           [pv(4),tuple(6),v(1)]
         ],
         [ [pv(1),tuple(7),[cons,v(1),v(2)]],
           [pv(1),tuple(8),v(2)]
         ]
       ]).


% SCHEMATA 4-6 .
% ΣΧΗΜΑΤΑ ΠΟΥ ΑΦΟΡΟΥΝ ΕΠΕΞΕΡΓΑΣΙΑ ΕΝΟΣ ΣΤΟΙΧΕΙΟΥ ΜΕ ΙΔΙΟΤΗΤΑ/-ΕΣ
% ΚΑΙ ΕΠΙΣΤΡΟΦΗ ΚΑΠΟΙΟΥ ΑΠΟΤΕΛΕΣΜΑΤΟΣ.


% schema_4
% Έλεγχος ύπαρξης μιας ιδιότητας σε στοιχείο λίστας,και επεξεργασία του.
% επιστροφή αποτελέσματος μετά την επεξεργασία του.

schema(t4,
[ 
 [  [pv(1),tuple(1),[cons,v(1),v(2)],v(3)] ,
    [pv(2),tuple(2),v(1)] ,
    [pv(3),tuple(3),v(1),v(2),v(3)]  ],
 [ [pv(1),tuple(4),[cons,v(1),v(2)],v(3)] , 
   [pv(1),tuple(5),v(2),v(3)]  ]
     ] ).


% Schema_5
% Έλεγχος ύπαρξης μίας εκ δυο ιδιοτήτων σε κάποιο από  τα στοιχεία μιας λίστας και 
% αντίστοιχη επεξεργασία του.


schema(5,
               [
                [ [pv(1),tuple(1),[cons,v(1),v(2)],v(3)],
                  [pv(2),tuple(2),v(1)],
                  [pv(3),tuple(3),v(1),v(2),v(3)]
                ],
                [ [pv(1),tuple(4),[cons,v(1),v(2)],v(3)],
                  [pv(4),tuple(5),v(1)],
                  [pv(5),tuple(6),v(1),v(2),v(3)]
                ],
                [ [pv(1),tuple(7),[cons,v(1),v(2)],v(3)],
                  [pv(1),tuple(8),v(2),v(3)]
                ]
              ]).




% Schema_6
% Έλεγχος ύπαρξης μίας εκ τριών ιδιοτήτων σε κάποιο από  τα στοιχεία μιας λίστας και 
% αντίστοιχη επεξεργασία του.


schema(6,
               [
                [ [pv(1),tuple(1),[cons,v(1),v(2)],v(3)],
                  [pv(2),tuple(2),v(1)],
                  [pv(3),tuple(3),v(1),v(2),v(3)]
                ],
                [ [pv(1),tuple(4),[cons,v(1),v(2)],v(3)],
                  [pv(4),tuple(5),v(1)],
                  [pv(5),tuple(6),v(1),v(2),v(3)]
                ],
                [ [pv(1),tuple(7),[cons,v(1),v(2)],v(3)],
                  [pv(6),tuple(8),v(1)],
                  [pv(7),tuple(9),v(1),v(2),v(3)]
                ],
                [ [pv(1),tuple(10),[cons,v(1),v(2)],v(3)],
                  [pv(1),tuple(11),v(2),v(3)]
                ]
              ]).




%SCHEMATA 7-9 .
% ΕΛΕΓΧΟΣ ΟΛΗΣ ΤΗΣ ΛΙΣΤΑΣ ΓΙΑ ΤΗΝ ΥΠΑΡΞΗ ΜΙΑΣ Ή 
% ΠΕΡΙΣΣΟΤΕΡΩΝ ΙΔΙΟΤΗΤΩΝ.


% schema_7
% Έλεγχος ύπαρξης μιας ιδιότητας σε όλα τα στοιχεία μιας λίστας.

schema(7,
    [ 
       [ [pv(1),tuple(1),nil]
       ],
       [ [pv(1),tuple(2),[cons,v(1),v(2)] ],
         [pv(2),tuple(3),v(1)] ,
         [pv(1),tuple(4),v(2)]
       ]
    ] ).




% Schema_ 8.
% Έλεγχος όλων των στοιχείων μιας λίστας για ύπαρξη μίας εκ' δύο ιδιοτήτων.

 schema(8,
       [
         [ [pv(1),tuple(1),nil]
         ],
         [ [pv(1),tuple(2),[cons,v(1),v(2)]],
           [pv(2),tuple(3),v(1)],
           [pv(1),tuple(4),v(2)]
         ],
        [ [pv(1),tuple(5),[cons,v(1),v(2)]],
           [pv(3),tuple(6),v(1)],
           [pv(1),tuple(7),v(2)]
         ]
       ]).


% Schema_ 9.
% Έλεγχος όλων των στοιχείων μιας λίστας για ύπαρξη μίας εκ' τριών ιδιοτήτων.

schema(9,
       [
         [ [pv(1),tuple(1),nil]
         ],
         [ [pv(1),tuple(2),[cons,v(1),v(2)]],
           [pv(2),tuple(3),v(1)],
           [pv(1),tuple(4),v(2)]
         ],
        [ [pv(1),tuple(5),[cons,v(1),v(2)]],
           [pv(3),tuple(6),v(1)],
           [pv(1),tuple(7),v(2)]
         ],
        [ [pv(1),tuple(8),[cons,v(1),v(2)]],
           [pv(4),tuple(9),v(1)],
           [pv(1),tuple(10),v(2)]
         ]
       ]).


%SCHEMATA  10-13 .
% ΕΠΕΞΕΡΓΑΣΙΑ ΜΕΤΑ ΤΟΝ ΕΛΕΓΧΟ ΟΛΩΝ ΤΩΝ ΣΤΟΙΧΕΙΩΝ ΜΙΑΣ ΛΙΣΤΑΣ.

% Schema_ 10.
% Έλεγχος όλων των στοιχείων μιας λίστας για ύπαρξη μίας εκ' δύο ιδιοτήτων και επεξεργασία τους.

 schema(10,
       [
         [ [pv(1),tuple(1),nil,v(1)]
         ],
         [ [pv(1),tuple(2),[cons,v(1),v(2)],v(3)],
           [pv(2),tuple(3),v(1)],
           [pv(1),tuple(4),v(2),v(4)],
           [pv(3),tuple(5),v(1),v(4),v(3)]
         ],
        [ [pv(1),tuple(6),[cons,v(1),v(2)],v(3)],
           [pv(4),tuple(7),v(1)],
           [pv(1),tuple(8),v(2),v(4)],
           [pv(5),tuple(9),v(1),v(4),v(3)]
         ]
       ]).


% Schema_ 11.
% Έλεγχος όλων των στοιχείων μιας λίστας για ύπαρξη μίας εκ τριών ιδιοτήτων και επεξεργασία τους.

 schema(11,
       [
         [ [pv(1),tuple(1),nil,v(1)]
         ],
         [ [pv(1),tuple(2),[cons,v(1),v(2)],v(3)],
           [pv(2),tuple(3),v(1)],
           [pv(1),tuple(4),v(2),v(4)],
           [pv(3),tuple(5),v(1),v(4),v(3)]
         ],
        [ [pv(1),tuple(6),[cons,v(1),v(2)],v(3)],
           [pv(4),tuple(7),v(1)],
           [pv(1),tuple(8),v(2),v(4)],
           [pv(5),tuple(9),v(1),v(4),v(3)]
         ],
        [ [pv(1),tuple(10),[cons,v(1),v(2)],v(3)],
           [pv(5),tuple(11),v(1)],
           [pv(1),tuple(12),v(2),v(4)],
           [pv(6),tuple(13),v(1),v(4),v(3)]
         ]
       ]).


% schema_12
% 
% Επιστροφή αποτελέσματος μετά την σειριακή επεξεργασία όλων των στοιχείων μιας λίστας.

schema(12,
     [  [ [pv(1),tuple(1),nil,v(1)]],
        [ [pv(1),tuple(2), [cons,v(1),v(2)],v(3)] ,
          [pv(2),tuple(3),v(1),v(4)],
          [pv(1),tuple(4),v(2),v(5)] ,
          [pv(3),tuple(5),v(4),v(5),v(3)]  ]
     ]).


% schema_13
% 
% Επιστροφή αποτελέσματος μετά την μη σειριακή επεξεργασία όλων των στοιχείων μιας λίστας.

schema(13,
     [  [ [pv(1),tuple(1),nil,v(1)]],
        [ [pv(1),tuple(2), [cons,v(1),v(2)],v(3)] ,
          [pv(2),tuple(3),v(1),v(2),v(4),v(5)],
          [pv(3),tuple(4),v(4),v(6)],
          [pv(1),tuple(5),v(5),v(7)] ,
          [pv(4),tuple(6),v(6),v(7),v(3)]  ]
     ]).


% SCEMATA 14-17 .
% ΣΧΗΜΑΤΑ ΕΠΕΞΕΡΓΑΣΙΑΣ ΣΤΟΙΧΕΙΟΥ/ΣΤΟΙΧΕΙΩΝ ΜΕΤΑ ΑΠΟ ΕΡΕΥΝΑ 
% ΣΕ ΟΛΗ ΤΗ ΛΙΣΤΑ 'Η ΤΜΗΜΑ ΑΥΤΗΣ.

% Schema 14.
% Βασική περίπτωση.

schema(14,
           [ 
             [ [pv(1),tuple(1),[cons,v(1),v(2)],v(3)],
               [pv(2),tuple(2),v(1)],
               [pv(3),tuple(3),v(1),v(2),v(3)] ],
             [ [pv(1),tuple(4),nil,v(1)],
                [pv(4),tuple(5),v(1)] ],
             [ [pv(1),tuple(6),[cons,v(1),v(2)],v(3)],
               [pv(5),tuple(7),v(1)],
               [pv(1),tuple(8),v(2),v(4)],
               [pv(6),tuple(9),v(1),v(4),v(3)] ]
           ]).     



% Schema 15.
% περίπτωση 2n.

schema(15,
           [ 
             [ [pv(1),tuple(1),[cons,v(1),v(2)],v(3)],
               [pv(2),tuple(2),v(1)],
               [pv(3),tuple(3),v(1),v(2),v(3)] ],
             [ [pv(1),tuple(4),[cons,v(1),v(2)],v(3)],
               [pv(4),tuple(5),v(1)],
               [pv(5),tuple(6),v(1),v(2),v(3)] ],
             [ [pv(1),tuple(7),nil,v(1)],
                [pv(6),tuple(8),v(1)] ],
             [ [pv(1),tuple(9),[cons,v(1),v(2)],v(3)],
               [pv(7),tuple(10),v(1)],
               [pv(1),tuple(11),v(2),v(4)],
               [pv(8),tuple(12),v(1),v(4),v(3)] ]
           ]).     


% Schema 16.
% περίπτωση 3n.

schema(16,
           [ 
             [ [pv(1),tuple(1),[cons,v(1),v(2)],v(3)],
               [pv(2),tuple(2),v(1)],
               [pv(3),tuple(3),v(1),v(2),v(3)] ],
             [ [pv(1),tuple(4),nil,v(1)],
                [pv(4),tuple(5),v(1)] ],
             [ [pv(1),tuple(6),[cons,v(1),v(2)],v(3)],
               [pv(5),tuple(7),v(1)],
               [pv(1),tuple(8),v(2),v(4)],
               [pv(6),tuple(9),v(1),v(4),v(3)] ],
             [ [pv(1),tuple(10),[cons,v(1),v(2)],v(3)],
               [pv(7),tuple(11),v(1)],
               [pv(1),tuple(12),v(2),v(4)],
               [pv(8),tuple(13),v(1),v(4),v(3)] ]
           ]).     



% Schema 17.
% περίπτωση 4n.

schema(17,
           [ 
             [ [pv(1),tuple(1),[cons,v(1),v(2)],v(3)],
               [pv(2),tuple(2),v(1)],
               [pv(3),tuple(3),v(1),v(2),v(3)] ],
             [ [pv(1),tuple(4),[cons,v(1),v(2)],v(3)],
               [pv(4),tuple(5),v(1)],
               [pv(5),tuple(6),v(1),v(2),v(3)] ],
             [ [pv(1),tuple(7),nil,v(1)],
                [pv(6),tuple(8),v(1)] ],
             [ [pv(1),tuple(9),[cons,v(1),v(2)],v(3)],
               [pv(7),tuple(10),v(1)],
               [pv(1),tuple(11),v(2),v(4)],
               [pv(8),tuple(12),v(1),v(4),v(3)] ],
             [ [pv(1),tuple(13),[cons,v(1),v(2)],v(3)],
               [pv(9),tuple(14),v(1)],
               [pv(1),tuple(15),v(2),v(4)],
               [pv(10),tuple(16),v(1),v(4),v(3)] ]
           ]).     



%SCHEMATA 18-21. ΠΡΟΓΡΑΜΜΑΤΙΣΤΙΚΕΣ ΤΕΧΝΙΚΕΣ.

% schema_18
% Επεξεργασία στοιχείων με συσσώρευση στην κεφαλή-Βασική περίπτωση.

schema(18,
     [  [ [pv(1),tuple(1),v(1),v(2)],
          [pv(2),tuple(2),v(1)],
          [pv(3),tuple(3),v(1),v(2)]  ],
        [ [pv(1),tuple(4),[cons,v(1),v(2)],v(3)],
          [pv(4),tuple(5),[cons,v(1),v(2)]],
          [pv(5),tuple(6),v(1),v(4)],
          [pv(1),tuple(7),v(2),v(5)],
          [pv(6),tuple(8),v(4),v(5),v(3)] ]
      ]).



% Schema_ 19.
% Επεξεργασία στοιχείων με συσσώρευση στην κεφαλή -περίπτωση 2η.


schema(19,
     [  [ [pv(1),tuple(1),v(1),v(2)],
          [pv(2),tuple(2),v(1)],
          [pv(3),tuple(3),v(1),v(2)]  ],
       [  [pv(1),tuple(4),v(1),v(2)],
          [pv(4),tuple(5),v(1)],
          [pv(5),tuple(6),v(1),v(2)]  ],
        [ [pv(1),tuple(7),[cons,v(1),v(2)],v(3)],
          [pv(6),tuple(8),[cons,v(1),v(2)]],
          [pv(7),tuple(9),v(1),v(4)],
          [pv(1),tuple(10),v(2),v(5)],
          [pv(8),tuple(11),v(4),v(5),v(3)] ]
     ]).


% schema_20
% Επεξεργασία στοιχείων με συσσώρευση στην κεφαλή-περίπτωση 3η.

schema(20,
     [  [ [pv(1),tuple(1),v(1),v(2)],
          [pv(2),tuple(2),v(1)],
          [pv(3),tuple(3),v(1),v(2)]  ],
        [ [pv(1),tuple(4),[cons,v(1),v(2)],v(3)],
          [pv(4),tuple(5),[cons,v(1),v(2)]],
          [pv(5),tuple(6),v(1),v(4)],
          [pv(1),tuple(7),v(2),v(5)],
          [pv(6),tuple(8),v(4),v(5),v(3)] ],
        [ [pv(1),tuple(9),[cons,v(1),v(2)],v(3)],
          [pv(7),tuple(10),[cons,v(1),v(2)]],
          [pv(8),tuple(11),v(1),v(4)],
          [pv(1),tuple(12),v(2),v(5)],
          [pv(9),tuple(13),v(4),v(5),v(3)] ]
      ]).


% Schema_ 21.
% Επεξεργασία στοιχείων με συσσώρευση στην κεφαλή-περίπτωση 4η.


schema(21,
     [  [ [pv(1),tuple(1),v(1),v(2)],
          [pv(2),tuple(2),v(1)],
          [pv(3),tuple(3),v(1),v(2)]  ],
        [ [pv(1),tuple(4),v(1),v(2)],
          [pv(4),tuple(5),v(1)],
          [pv(5),tuple(6),v(1),v(2)]  ],
        [ [pv(1),tuple(7),[cons,v(1),v(2)],v(3)],
          [pv(6),tuple(8),[cons,v(1),v(2)]],
          [pv(7),tuple(9),v(1),v(4)],
          [pv(1),tuple(10),v(2),v(5)],
          [pv(8),tuple(11),v(4),v(5),v(3)] ],
        [ [pv(1),tuple(12),[cons,v(1),v(2)],v(3)],
          [pv(9),tuple(13),[cons,v(1),v(2)]],
          [pv(10),tuple(14),v(1),v(4)],
          [pv(1),tuple(15),v(2),v(5)],
          [pv(11),tuple(16),v(4),v(5),v(3)] ]
      ]).


% schema_22
% Επεξεργασία στοιχείων με συσσώρευση στο σώμα-Βασική περίπτωση.

schema(22,
     [ 
        [ [pv(1),tuple(1),v(1),v(2)],
          [pv(2),tuple(2),v(1),v(3)],
          [pv(3),tuple(3),v(1),v(3),v(2)] ],
        [ [pv(3),tuple(4),v(1),v(2),v(3)],
          [pv(4),tuple(5),v(1)] ],
        [ [pv(3),tuple(6),[cons,v(1),v(2)],v(3),v(4)],
          [pv(5),tuple(7),[cons,v(1),v(2)],v(3)],
          [pv(6),tuple(8),v(1),v(5)],
          [pv(3),tuple(9),v(5),v(3),v(6)],
          [pv(7),tuple(10),v(2),v(6),v(4)] ]
      ]).


% schema_23
% Επεξεργασία στοιχείων με συσσώρευση στο σώμα- περίπτωση 2η.

schema(23,
     [ 
        [ [pv(1),tuple(1),v(1),v(2)],
          [pv(2),tuple(2),v(1),v(3)],
          [pv(3),tuple(3),v(1),v(3),v(2)] ],
        [ [pv(3),tuple(4),v(1),v(2),v(3)],
          [pv(4),tuple(5),v(1)] ],
        [ [pv(3),tuple(6),v(1),v(2),v(3)],
          [pv(5),tuple(7),v(1)] ],
        [ [pv(3),tuple(8),[cons,v(1),v(2)],v(3),v(4)],
          [pv(6),tuple(9),[cons,v(1),v(2)],v(3)],
          [pv(7),tuple(10),v(1),v(5)],
          [pv(3),tuple(11),v(5),v(3),v(6)],
          [pv(8),tuple(12),v(2),v(6),v(4)] ]
      ]).



% schema_24
% Επεξεργασία στοιχείων με συσσώρευση στο σώμα-περίπτωση 3η.

schema(24,
     [ 
        [ [pv(1),tuple(1),v(1),v(2)],
          [pv(2),tuple(2),v(1),v(3)],
          [pv(3),tuple(3),v(1),v(3),v(2)] ],
        [ [pv(3),tuple(4),v(1),v(2),v(3)],
          [pv(4),tuple(5),v(1)] ],
        [ [pv(3),tuple(6),[cons,v(1),v(2)],v(3),v(4)],
          [pv(5),tuple(7),[cons,v(1),v(2)],v(3)],
          [pv(6),tuple(8),v(1),v(5)],
          [pv(3),tuple(9),v(5),v(3),v(6)],
          [pv(7),tuple(10),v(2),v(6),v(4)] ],
        [ [pv(3),tuple(11),[cons,v(1),v(2)],v(3),v(4)],
          [pv(8),tuple(12),[cons,v(1),v(2)],v(3)],
          [pv(9),tuple(13),v(1),v(5)],
          [pv(3),tuple(14),v(5),v(3),v(6)],
          [pv(10),tuple(15),v(2),v(6),v(4)] ]
      ]).



% schema_25
% Επεξεργασία στοιχείων με συσσώρευση στο σώμα- περίπτωση 4η.

schema(25,
     [ 
        [ [pv(1),tuple(1),v(1),v(2)],
          [pv(2),tuple(2),v(1),v(3)],
          [pv(3),tuple(3),v(1),v(3),v(2)] ],
        [ [pv(3),tuple(4),v(1),v(2),v(3)],
          [pv(4),tuple(5),v(1)] ],
        [ [pv(3),tuple(6),v(1),v(2),v(3)],
          [pv(5),tuple(7),v(1)] ],
        [ [pv(3),tuple(8),[cons,v(1),v(2)],v(3),v(4)],
          [pv(6),tuple(9),[cons,v(1),v(2)],v(3)],
          [pv(7),tuple(10),v(1),v(5)],
          [pv(3),tuple(11),v(5),v(3),v(6)],
          [pv(8),tuple(12),v(2),v(6),v(4)] ],
        [ [pv(3),tuple(13),[cons,v(1),v(2)],v(3),v(4)],
          [pv(9),tuple(14),[cons,v(1),v(2)],v(3)],
          [pv(10),tuple(15),v(1),v(5)],
          [pv(3),tuple(16),v(5),v(3),v(6)],
          [pv(11),tuple(17),v(2),v(6),v(4)] ]
      ]).


% Schema_26 .
% Περίπτωση εναλλαγής ορισμάτων ή χρήσης κάποιων εκ των ορισμάτων.



schema(26,
            [ 
             [ [pv(1),tuple(1)],
               [pv(2),tuple(2)]
             ] 
           ]).

