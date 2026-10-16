Name = Add Two Uniary Numbers
Description = Adds Two uniary Numbers

#How it works (lines starting with #> are the machine's explanation)
#> Adds two unary numbers. The input is A c B, where A and B are runs of 0s: 00c000 means 2 + 3.
#>
#> How it works:
#> 1. Q0 marks the leftmost unused 0 of A with x and moves right (Q1).
#> 2. Q1 and Q2 run right over the rest of A, the separator c and all of B, then write one extra 0 on the first blank after B.
#> 3. Q3 and Q4 walk back left to the last x, and Q0 takes the next digit of A.
#> 4. When Q0 finds c instead of a 0, every digit of A has been copied, so it erases c and halts in Q5.
#>
#> Output for 00c000 is xx#00000: the five 0s are 2 + 3 (the xs are the used digits of A).

#The initial input alphabet
Tape_Alphabet = 0,c,#,x,d,?

#Blank Symbol of tape
Blank_Symbol = #

#Initial input String
Input = 00c000

#Initial head position on input string, count starts with 0
Position=0

#Maps to any symbol
Any_Symbol_Wild_Card =?

#Set of States
States = Q0,Q1,Q2,Q3,Q4,Q5

#Initial State
Initial_State = Q0

#Set of accepted final states after which machine halts
Final_States = Q5

#Shift of the head
Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Sift,	Comment
1,Q0,0,x,Q1,R, Mark the next unused digit of A as x
2,Q1,0,0,Q1,R, Skip the rest of A
3,Q1,c,c,Q2,R, Step over the separator c into B
4,Q2,0,0,Q2,R, Skip over B
5,Q2,#,0,Q3,L, Append one 0 after B, then turn back
6,Q3,0,0,Q3,L, Walk back over B
7,Q3,c,c,Q4,L, Step back over the separator c
8,Q4,0,0,Q4,L, Walk back over A
9,Q4,x,x,Q0,R, Found the last x: move on to the next digit of A
10,Q0,c,#,Q5,R, A is used up: erase c and halt