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
States = Q0,Q1,Q2,Q3,Q4,Q5,Q6

#Initial State
Initial_State = Q0

#Set of accepted final states after which machine halts
Final_States = Q6

Shift = Left,Right,No_Shift

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Sift
1, Q0,a,a,Q0,Right
2, Q0,b,b,Q0,Right
3, Q0,#,#,Q1,Left
3, Q1,x,x,Q1,Left
4, Q1,a,x,Q2,Right
5, Q1,b,x,Q3,Right
6, Q1,#,#,Q5,Right
7, Q2,a,a,Q2,Right
8, Q2,b,b,Q2,Right
9, Q2,x,x,Q2,Right
10,Q2,#,a,Q4,Left
11,Q3,a,a,Q3,Right
12,Q3,b,b,Q3,Right
13,Q3,x,x,Q3,Right
14,Q3,#,b,Q4,Left
15,Q4,a,a,Q4,Left
16,Q4,b,b,Q4,Left
17,Q4,x,x,Q1,Left
18,Q5,x,#,Q5,Right
19,Q5,b,b,Q6,No_Shift
20,Q5,a,a,Q6,No_Shift