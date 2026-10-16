Name = Six State busy beaver machine.
Description = The current 6-state busy beaver champion (found by mxdys, 2025). It does halt, but only after an unimaginable number of steps.

#How it works (lines starting with #> are the machine's explanation)
#> The 6-state busy beaver champion: 1RB1RA_1RC1RZ_1LD0RF_1RA0LE_0LD1RC_1RA0RE in the standard notation, found by mxdys in 2025 (listed as the champion on the bbchallenge.org wiki).
#>
#> Of all machines with 6 states and the symbols 0 and 1 that are known to halt on a blank tape, this one runs the longest: more than 10^^10^^10^^8 steps (towers of powers of ten), a number far too large to write down. It does halt, but no computer could ever run it to the end.
#>
#> What you can do here is watch how it starts: it grows a pattern of 1s, sweeping left and right in ever longer passes. The run pauses at the safety limit (Config tab); press Run again to continue. For comparison, the 3- and 4-state champions halt after 14 and 107 steps, and the 5-state champion after 47,176,870.
#>
#> Halt rule: B reading a 1 writes 1, moves right and halts (state H).

#The tape alphabet: every symbol that may appear on the tape
Tape_Alphabet = 0,1,?

#Blank Symbol of tape
Blank_Symbol = 0

#Maps to any symbol
Any_Symbol_Wild_Card = ?

#Initial input String
Input = 0

#Initial head position on input string, count starts with 0
Position = 0

#Set of States
States = A,B,C,D,E,F,H

#Initial State
Initial_State = A

#Set of accepted final states after which machine halts
Final_States = H

Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Shift,	Comment
1,A,0,1,B,R, A on a blank: write 1, move right, go to B
2,A,1,1,A,R, A on a 1: keep moving right
3,B,0,1,C,R, B on a blank: write 1, move right, go to C
4,B,1,1,H,R, B on a 1: halt (the only way to stop)
5,C,0,1,D,L, C on a blank: write 1, move left, go to D
6,C,1,0,F,R, C on a 1: erase it, move right, go to F
7,D,0,1,A,R, D on a blank: write 1, move right, back to A
8,D,1,0,E,L, D on a 1: erase it, move left, go to E
9,E,0,0,D,L, E on a blank: move left, go to D
10,E,1,1,C,R, E on a 1: move right, go to C
11,F,0,1,A,R, F on a blank: write 1, move right, back to A
12,F,1,0,E,R, F on a 1: erase it, move right, go to E
