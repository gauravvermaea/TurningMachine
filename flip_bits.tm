Name = Flips the bits of the input string
Description = Flips 0 to 1 and 1 to in an input string until it reaches the end of the string.

#How it works (lines starting with #> are the machine's explanation)
#> Inverts a binary string: every 0 becomes 1 and every 1 becomes 0.
#>
#> Q0 moves right one cell at a time, flipping the bit it reads. When it reaches the blank # at the end it stops in Q1 without moving.
#>
#> Output for 000111# is 111000#.

#The initial input alphabet
Tape_Alphabet = 0,1,#,?

#Blank Symbol of tape
Blank_Symbol = #

#Initial input String
Input = 000111#

#Initial head position on input string, count starts with 0
Position=0

#Maps to any symbol
Any_Symbol_Wild_Card =?

#Set of States
States = Q0,Q1

#Initial State
Initial_State = Q0

#Set of accepted final states after which machine halts
Final_States = Q1

#Shift of the head
Left_Shift_Symbol = Left
Right_Shift_Symbol = Right
No_Shift_Symbol = No_Shift

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Sift,	Comment
1,Q0,0,1,Q0,Right, Flip 0 to 1
2,Q0,1,0,Q0,Right, Flip 1 to 0
3,Q0,#,#,Q1,No_Shift, End of the input: stop