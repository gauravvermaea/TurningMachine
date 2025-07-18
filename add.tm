Name = Add Two Uniary Numbers
Description = Adds Two uniary Numbers

#The initial input alphabet
Tape_Alphabet = 0,c,#,x,d,?

#Blank Symbol of tape
Blank_Symbol = #

#Initial input String
Input = 00c00

#Initial head position on input string, count starts with 0
Position=0

#Maps to any symbol
Any_Symbol_Wild_Card =?

#Set of States
States = Q0,Q1,Q2,Q3,Q4,Q5

#Initial State
Initial_State = Q0

#Set of accepted final states after which machine halts
Final_States = Q5

#Shift of the head
Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Sift
1,Q0,0,x,Q1,R
2,Q1,0,0,Q1,R
3,Q1,c,c,Q2,R
4,Q2,0,0,Q2,R
5,Q2,#,0,Q3,L
6,Q3,0,0,Q3,L
7,Q3,c,c,Q4,L
8,Q4,0,0,Q4,L
9,Q4,x,x,Q0,R
10,Q0,c,#,Q5,R