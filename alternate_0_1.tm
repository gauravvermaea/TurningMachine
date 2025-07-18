Name = Alternately fills 0 and 1 in a string
Description = Alternately fills 0 and 1 in a string

#The initial input alphabet
Tape_Alphabet = 0,1,#,?,t

#Blank Symbol of tape
Blank_Symbol = #

#Initial input String
Input = #########t

#Initial head position on input string, count starts with 0
Position=0

#Maps to any symbol
Any_Symbol_Wild_Card =?

#Set of States
States = Q0,Q1,Q2

#Initial State
Initial_State = Q0

#Set of accepted final states after which machine halts
Final_States = Q2

#Shift of the head
Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Sift
1,Q0,?,0,Q1,R
2,Q1,?,1,Q0,R
3,Q0,t,t,Q2,R
4,Q1,t,t,Q2,N