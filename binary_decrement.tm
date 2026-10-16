Name = Binary Decrement
Description = Subtracts 1 from a binary number; halts in Underflow if the number was 0

#How it works (lines starting with #> are the machine's explanation)
#> Subtracts 1 from a binary number: from the right, turn 0s into 1s while there is a borrow, and the first 1 into a 0.
#>
#> How it works:
#> 1. Right runs to the end of the number.
#> 2. Borrow moves left: each 0 becomes 1 (the borrow continues); the first 1 becomes 0 and the machine halts in Done.
#> 3. If the borrow runs off the left end, the number was 0 and cannot go lower: the machine halts in Underflow.
#>
#> Leading zeros are kept: 1000 (8) becomes 0111 (7). Output for 1100 (12) is 1011 (11).

#The tape alphabet: every symbol that may appear on the tape
Tape_Alphabet = 0,1,#,?

#Blank Symbol of tape
Blank_Symbol = #

#Maps to any symbol
Any_Symbol_Wild_Card = ?

#Initial input String
Input = 1100

#Initial head position on input string, count starts with 0
Position = 0

#Set of States
States = Right,Borrow,Done,Underflow

#Initial State
Initial_State = Right

#Set of accepted final states after which machine halts
Final_States = Done,Underflow

Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Shift,	Comment
1,Right,0,0,Right,R, Run to the end of the number
2,Right,1,1,Right,R, Run to the end of the number
3,Right,#,#,Borrow,L, End reached: start subtracting from the last digit
4,Borrow,0,1,Borrow,L, 0 - 1: write 1 and borrow from the left
5,Borrow,1,0,Done,N, 1 minus 1 is 0: no borrow, finished
6,Borrow,#,#,Underflow,R, Borrow past the left end: the number was 0
