Name = Four State busy beaver machine.
Description = Implementation of a 4 state busy beaver machine.

#How it works (lines starting with #> are the machine's explanation)
#> The 4-state busy beaver. Of all machines with 4 states and the symbols 0 and 1 that halt when started on a blank tape, this one writes the most 1s: thirteen.
#>
#> Like every busy beaver, its rules come from an exhaustive search, not from a plan. It sweeps left and right for 107 steps and halts when C reads a blank.
#>
#> Rule 8 was corrected to D,1 -> 0,A,R. With L, as in the original file, the machine never halts.
#> Result: 13 ones in 107 steps.

#The initial input alphabet
Tape_Alphabet = 0,1,?

#Blank Symbol of tape
Blank_Symbol = 0

#Maps to any symbol
Any_Symbol_Wild_Card =?

#Initial input String
Input = 0

#Initial head position on input string, count starts with 0
Position=0

#Set of States
States = A,B,C,D,H

#Initial State
Initial_State = A

#Set of accepted final states after which machine halts
Final_States = H

#Shift of the head
Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Sift,	Comment
1,A,0,1,B,R, A on a blank: write 1, move right, go to B
2,B,0,1,A,L, B on a blank: write 1, move left, back to A
3,C,0,1,H,R, C on a blank: write 1 and halt (the only way to stop)
4,D,0,1,D,R, D on a blank: write 1 and keep moving right
5,A,1,1,B,L, A on a 1: move left, go to B
6,B,1,0,C,L, B on a 1: erase it, move left, go to C
7,C,1,1,D,L, C on a 1: move left, go to D
8,D,1,0,A,R, D on a 1: erase it, move right, back to A (corrected from L)