Name = Recognise a^n b^n
Description = Decides whether the input is some a's followed by the same number of b's

#How it works (lines starting with #> are the machine's explanation)
#> Decides whether the input is n a's followed by exactly n b's (aabb, aaabbb, ...), halting in Accept or Reject.
#> This language needs unbounded counting, so no finite automaton can recognise it; a Turing machine can.
#>
#> How it works:
#> 1. Start crosses off the first remaining a (X).
#> 2. FindB runs right to the first remaining b and crosses it off (Y); Back returns to the last X.
#> 3. When Start finds Y instead of an a, every a is matched: CheckRest makes sure only Ys are left, then Accept.
#> Anything out of place (a b first, an a after the b's, too few or too many b's) leads to Reject.

#The tape alphabet: every symbol that may appear on the tape
Tape_Alphabet = a,b,X,Y,#,?

#Blank Symbol of tape
Blank_Symbol = #

#Maps to any symbol
Any_Symbol_Wild_Card = ?

#Initial input String
Input = aaabbb

#Initial head position on input string, count starts with 0
Position = 0

#Set of States
States = Start,FindB,Back,CheckRest,Accept,Reject

#Initial State
Initial_State = Start

#Set of accepted final states after which machine halts
Final_States = Accept,Reject

Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Shift,	Comment
1,Start,a,X,FindB,R, Cross off the next a
2,Start,Y,Y,CheckRest,R, All a's used: only matched b's may be left
3,Start,#,#,Accept,N, Empty input: zero a's and zero b's
4,Start,b,b,Reject,N, A b with no a before it
5,FindB,a,a,FindB,R, Skip the remaining a's
6,FindB,Y,Y,FindB,R, Skip b's already matched
7,FindB,b,Y,Back,L, Cross off the matching b
8,FindB,#,#,Reject,N, Not enough b's
9,Back,a,a,Back,L, Walk back
10,Back,Y,Y,Back,L, Walk back
11,Back,X,X,Start,R, Found the last X: take the next a
12,CheckRest,Y,Y,CheckRest,R, Skip matched b's
13,CheckRest,#,#,Accept,N, Same number of a's and b's
14,CheckRest,b,b,Reject,N, Too many b's
15,CheckRest,a,a,Reject,N, An a after the b's
