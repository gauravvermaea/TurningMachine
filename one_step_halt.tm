Name = Halts after First Input
Description = Halts the turing machine after first run. It showcases the any charecter match feature

#The initial input alphabet
Tape_Alphabet = #,?,1,2,3,4,5,6,7,c

#Blank Symbol of tape
Blank_Symbol = #

#Initial input String
Input = #1234567

#Initial head position on input string, count starts with 0
Position=3

#Maps to any symbol
Any_Symbol_Wild_Card =?

#Set of States
States = Q0,Q1

#Initial State
Initial_State = Q0

#Set of accepted final states after which machine halts
Final_States = Q1

#Shift of the head
Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Sift
1,Q0,?,c,Q1,R