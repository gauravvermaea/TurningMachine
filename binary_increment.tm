Name = Binary Increment
Description = Adds 1 to a binary number

#How it works (lines starting with #> are the machine's explanation)
#> Adds 1 to a binary number, the way you would by hand: from the right, turn 1s into 0s while there is a carry, and the first 0 into a 1.
#>
#> How it works:
#> 1. Right runs to the end of the number.
#> 2. Carry moves left: each 1 becomes 0 (the carry continues); the first 0 becomes 1 and the machine halts.
#> 3. If the carry runs off the left end (the number was all 1s), a new leading 1 is written there: 111 becomes 1000.
#>
#> Output for 1011 (11) is 1100 (12).

#The tape alphabet: every symbol that may appear on the tape
Tape_Alphabet = 0,1,#,?

#Blank Symbol of tape
Blank_Symbol = #

#Maps to any symbol
Any_Symbol_Wild_Card = ?

#Initial input String
Input = 1011

#Initial head position on input string, count starts with 0
Position = 0

#Set of States
States = Right,Carry,Done

#Initial State
Initial_State = Right

#Set of accepted final states after which machine halts
Final_States = Done

Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Shift,	Comment
1,Right,0,0,Right,R, Run to the end of the number
2,Right,1,1,Right,R, Run to the end of the number
3,Right,#,#,Carry,L, End reached: start adding from the last digit
4,Carry,1,0,Carry,L, 1 plus 1 is 10: write 0 and carry left
5,Carry,0,1,Done,N, 0 plus 1 is 1: no carry, finished
6,Carry,#,1,Done,N, Carry past the left end: new leading 1
