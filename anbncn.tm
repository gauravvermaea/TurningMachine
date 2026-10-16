Name = Recognise a^n b^n c^n
Description = Decides whether the input is n a's, then n b's, then n c's

#How it works (lines starting with #> are the machine's explanation)
#> Decides whether the input is n a's, then n b's, then n c's (abc, aabbcc, ...), halting in Accept or Reject.
#> Not even a pushdown automaton (a machine with a stack) can recognise this language, but a Turing machine can: it shows the extra power of a tape you can go back and forth on.
#>
#> How it works:
#> 1. Start crosses off an a (X), FindB crosses off the next b (Y) and FindC the next c (Z).
#> 2. Back returns to the last X and the next round begins.
#> 3. When Start sees Y instead of an a, Check makes sure only Ys and Zs are left: Accept. Any character out of place, or a missing b or c, leads to Reject.

#The tape alphabet: every symbol that may appear on the tape
Tape_Alphabet = a,b,c,X,Y,Z,#,?

#Blank Symbol of tape
Blank_Symbol = #

#Maps to any symbol
Any_Symbol_Wild_Card = ?

#Initial input String
Input = aabbcc

#Initial head position on input string, count starts with 0
Position = 0

#Set of States
States = Start,FindB,FindC,Back,Check,Accept,Reject

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
2,Start,Y,Y,Check,R, All a's used: only matched letters may be left
3,Start,#,#,Accept,N, Empty input: n is 0
4,Start,b,b,Reject,N, A b with no a before it
5,Start,c,c,Reject,N, A c with no a before it
6,FindB,a,a,FindB,R, Skip the remaining a's
7,FindB,Y,Y,FindB,R, Skip b's already matched
8,FindB,b,Y,FindC,R, Cross off the matching b
9,FindB,c,c,Reject,N, Not enough b's
10,FindB,Z,Z,Reject,N, Not enough b's
11,FindB,#,#,Reject,N, Not enough b's
12,FindC,b,b,FindC,R, Skip the remaining b's
13,FindC,Z,Z,FindC,R, Skip c's already matched
14,FindC,c,Z,Back,L, Cross off the matching c
15,FindC,a,a,Reject,N, An a after the b's
16,FindC,#,#,Reject,N, Not enough c's
17,Back,a,a,Back,L, Walk back
18,Back,b,b,Back,L, Walk back
19,Back,Y,Y,Back,L, Walk back
20,Back,Z,Z,Back,L, Walk back
21,Back,X,X,Start,R, Found the last X: take the next a
22,Check,Y,Y,Check,R, Skip matched b's
23,Check,Z,Z,Check,R, Skip matched c's
24,Check,#,#,Accept,N, Same number of a's, b's and c's
25,Check,a,a,Reject,N, Letters out of order
26,Check,b,b,Reject,N, Too many b's
27,Check,c,c,Reject,N, Too many c's
