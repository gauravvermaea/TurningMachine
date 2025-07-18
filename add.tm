Name = Add Two Uniary Numbers
Description = Adds Two uniary Numbers

#The initial input alphabet
Tape_Alphabet = 0,c,#,x,d

#Blank Symbol of tape
Blank_Symbol = #

#Initial input String
Input = 000c0000000

#Initial head position on input string, count starts with 0
Position=0

#Set of States
States = Q0,Q1,Q2,Q3,Q4,Q5

#Initial State
Initial_State = Q0

#Set of accepted final states after which machine halts
Final_States = Q5

Shift = Left,Right,No_Shift

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Sift
1,Q0,0,x,Q1,Right
2,Q1,0,0,Q1,Right
3,Q1,c,c,Q2,Right
4,Q2,0,0,Q2,Right
5,Q2,#,0,Q3,Left
6,Q3,0,0,Q3,Left
7,Q3,c,c,Q4,Left
8,Q4,0,0,Q4,Left
9,Q4,x,x,Q0,Right
10,Q0,c,#,Q5,Right