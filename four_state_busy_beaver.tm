Name = Flips the bits of the input string
Description = Flips 0 to 1 and 1 to in an input string until it reaches the end of the string.

#The initial input alphabet
Tape_Alphabet = 0,1

#Blank Symbol of tape
Blank_Symbol = 0

#Initial input String
Input = 0000000000000000000

#Initial head position on input string, count starts with 0
Position=6

#Set of States
States = A,B,C,H

#Initial State
Initial_State = A

#Set of accepted final states after which machine halts
Final_States = H

Shift = Left,Right,No_Shift

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Sift
1,A,0,1,B,Right
2,B,0,0,C,Right
3,C,0,1,C,Left
4,A,1,1,H,Right
5,B,1,1,B,Right
6,C,1,1,A,Left