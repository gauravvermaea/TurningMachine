Name = Three State busy beaver machine.
Description = Implementation of a 3 state busy beaver machine.

#How it works (lines starting with #> are the machine's explanation)
#> The 3-state busy beaver. Of all machines with 3 states and the symbols 0 and 1 that halt when started on a blank tape, this one writes the most 1s: six.
#>
#> There is no step-by-step plan behind it: busy beavers are found by searching every possible machine. Watch the head sweep back and forth building a block of 1s, until A reads a 1 and halts in H.
#>
#> Result: 6 ones in 14 steps (0000011111100000000). H is the halt state.

#The initial input alphabet
Tape_Alphabet = 0,1,?

#Blank Symbol of tape
Blank_Symbol = 0

#Maps to any symbol
Any_Symbol_Wild_Card =?

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

#Shift of the head
Left_Shift_Symbol = Left
Right_Shift_Symbol = Right
No_Shift_Symbol = No_Shift

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Sift,	Comment
1,A,0,1,B,Right, A on a blank: write 1, move right, go to B
2,B,0,0,C,Right, B on a blank: leave it, move right, go to C
3,C,0,1,C,Left, C on a blank: write 1 and keep moving left
4,A,1,1,H,Right, A on a 1: halt (the only way to stop)
5,B,1,1,B,Right, B on a 1: keep moving right over the 1s
6,C,1,1,A,Left, C on a 1: move left and go back to A