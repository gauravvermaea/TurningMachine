Name = Halts after encountering first a or end of tape. 
Description = Halts the after finding first a or end of tape. If a is found state is Q1 if not found it is Q2

#The initial input alphabet
Tape_Alphabet = a,b,c,d,e,#,?

#Blank Symbol of tape
Blank_Symbol = #

#Initial input String
Input = bcde

#Initial head position on input string, count starts with 0
Position=0

#Maps to any symbol
Any_Symbol_Wild_Card =?

#Set of States
States = Q0,Q1,Q2

#Initial State
Initial_State = Q0

#Set of accepted final states after which machine halts
Final_States = Q1,Q2

#Shift of the head
Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Sift
1,Q0,a,a,Q1,R
2,Q0,b,b,Q0,R
3,Q0,c,c,Q0,R
4,Q0,d,d,Q0,R
5,Q0,e,e,Q0,R
6,Q0,#,#,Q2,R