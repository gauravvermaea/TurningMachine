Name = Reverses a string
Description = Reverses a string

#The initial input alphabet
Tape_Alphabet = a,b,#,?,x

#Blank Symbol of tape
Blank_Symbol = #

#Initial input String
Input = #aabb#

#Initial head position on input string, count starts with 0
Position=1

#Maps to any symbol
Any_Symbol_Wild_Card =?

#Set of States
States = Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7

#Initial State
Initial_State = Q0

#Set of accepted final states after which machine halts
Final_States = Q7

#Shift of the head
Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Sift
1, Q0,a,a,Q0,R
2, Q0,b,b,Q0,R
3, Q0,#,#,Q1,L
3, Q1,x,x,Q1,L
4, Q1,a,x,Q2,R
5, Q1,b,x,Q3,R
6, Q1,#,#,Q5,R
7, Q2,a,a,Q2,R
8, Q2,b,b,Q2,R
9, Q2,x,x,Q2,R
10,Q2,#,a,Q4,L
11,Q3,a,a,Q3,R
12,Q3,b,b,Q3,R
13,Q3,x,x,Q3,R
14,Q3,#,b,Q4,L
15,Q4,a,a,Q4,L
16,Q4,b,b,Q4,L
17,Q4,x,x,Q1,L
18,Q5,x,#,Q5,R
19,Q5,b,b,Q6,N
20,Q5,a,a,Q6,N
21,Q6,a,a,Q6,R
22,Q6,b,b,Q6,R
23,Q6,#,#,Q7,N