Name = Multiply Two Unary Numbers
Description = Multiplies two unary numbers A c B; the product is left on the tape after the inputs are erased

#How it works (lines starting with #> are the machine's explanation)
#> Multiplies two unary numbers. The input is A c B, where A and B are runs of 0s: 00c000 means 2 x 3. The product is left on the tape and everything else is erased.
#>
#> How it works:
#> 1. Init and Rewind walk to the end of B, write a second separator e there, then walk back to the start of A.
#> 2. For every 0 in A (marked x when used), the machine goes through every 0 in B (marked y when used) and appends one 0 after e. Then it turns B's y marks back into 0s.
#> 3. When A has no unused 0 left, ClearA, SkipBlanks and ClearB erase A, c, B and e, leaving only the product.
#>
#> Output for 00c000 is ########000000: six 0s, and 2 x 3 = 6.
#> Zero works too: c000 (0 x 3) and 00c (2 x 0) both leave an empty result.

#The tape alphabet: 0 digit, c separator between A and B, e separator before the result,
#x marks a used digit of A, y marks a used digit of B, # blank, ? wildcard
Tape_Alphabet = 0,c,e,x,y,#,?

#Blank Symbol of tape
Blank_Symbol = #

#Maps to any symbol
Any_Symbol_Wild_Card = ?

#Initial input String (2 x 3)
Input = 00c000

#Initial head position on input string, count starts with 0
Position = 0

#Set of States
States = Init,Rewind,NextA,ToB,NextB,Append,BackToB,ResetB,BackToA,ClearA,SkipBlanks,ClearB,Done

#Initial State
Initial_State = Init

#Set of accepted final states after which machine halts
Final_States = Done

Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Shift,	Comment
#--- Setup: write the result separator e after B, then return to the start of A
1,Init,0,0,Init,R, Walk right over A
2,Init,c,c,Init,R, Walk over the separator c
3,Init,#,e,Rewind,L, Write the separator e after B, then turn back
4,Rewind,0,0,Rewind,L, Walk back over the digits
5,Rewind,c,c,Rewind,L, Walk back over c
6,Rewind,#,#,NextA,R, Left end reached: start with the first digit of A
#--- Take the next digit of A (mark it x); if A is used up, go and clean up
7,NextA,0,x,ToB,R, Mark the next digit of A as x
8,NextA,c,c,ClearA,L, A is used up: go and erase the inputs
9,ToB,0,0,ToB,R, Skip the rest of A
10,ToB,c,c,NextB,R, Step over c into B
#--- For each digit of B (mark it y), append one 0 to the result
11,NextB,0,y,Append,R, Mark the next digit of B as y
12,NextB,e,e,ResetB,L, B is used up for this digit of A: restore it
13,Append,0,0,Append,R, Run right over B and the result
14,Append,e,e,Append,R, Run over the separator e
15,Append,#,0,BackToB,L, Add one 0 to the result, then turn back
16,BackToB,0,0,BackToB,L, Walk back over the result and B
17,BackToB,e,e,BackToB,L, Walk back over e
18,BackToB,y,y,NextB,R, Found the last y: take the next digit of B
#--- B done for this digit of A: restore B's digits and go back to A
19,ResetB,y,0,ResetB,L, Turn y back into 0
20,ResetB,c,c,BackToA,L, B restored: walk back to A
21,BackToA,0,0,BackToA,L, Walk back over the unused digits of A
22,BackToA,x,x,NextA,R, Found the last x: take the next digit of A
#--- Clean up: erase A, the separator c, B and the separator e
23,ClearA,x,#,ClearA,L, Erase a used digit of A
24,ClearA,#,#,SkipBlanks,R, Left end reached: turn round
25,SkipBlanks,#,#,SkipBlanks,R, Skip the erased cells
26,SkipBlanks,c,#,ClearB,R, Erase the separator c
27,ClearB,0,#,ClearB,R, Erase B
28,ClearB,e,#,Done,R, Erase e; the head now stands on the product: halt
