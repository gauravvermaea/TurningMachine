Name = Divide Two Unary Numbers
Description = Divides unary A by unary B (B at least 1): the quotient and the remainder are left on the tape

#How it works (lines starting with #> are the machine's explanation)
#> Divides two unary numbers by repeated subtraction. The input is A c B, where A and B are runs of 0s: 0000000c00 means 7 / 2. B must be at least 1.
#>
#> How it works:
#> 1. Init writes a separator e after B; the quotient will be written after e.
#> 2. One unit at a time, the machine marks the next digit of B (y) and cancels the next digit of A (x).
#> 3. When every digit of B is marked, one copy of B has been taken away from A: AddQ adds a 0 to the quotient and ResetY turns B's y marks back into 0s.
#> 4. When A runs out, the y marks show how much of B was left to take: that is the remainder (minus the y that found no partner, which Unmark removes). The clean-up erases A, c and the rest of B, turns the remaining y marks into r, and halts.
#>
#> Output for 7 / 2 (0000000c00) is ...r##e000: one r before e (remainder 1) and three 0s after e (quotient 3).
#> Dividing by zero never halts: the quotient keeps growing until the safety limit pauses the run.

#The tape alphabet: every symbol that may appear on the tape
Tape_Alphabet = 0,c,e,x,y,r,#,?

#Blank Symbol of tape
Blank_Symbol = #

#Maps to any symbol
Any_Symbol_Wild_Card = ?

#Initial input String
Input = 0000000c00

#Initial head position on input string, count starts with 0
Position = 0

#Set of States
States = Init,Rewind,GoB,InB,GoA,FindA,AddQ,ResetB,ResetY,Unmark,LastY,CleanL,Clean,Done

#Initial State
Initial_State = Init

#Set of accepted final states after which machine halts
Final_States = Done

Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Shift,	Comment
1,Init,0,0,Init,R, Walk right over A
2,Init,c,c,Init,R, Walk over the separator c and B
3,Init,#,e,Rewind,L, Write the quotient separator e after B, then go back
4,Rewind,0,0,Rewind,L, Walk back to the left end
5,Rewind,c,c,Rewind,L, Walk back to the left end
6,Rewind,x,x,Rewind,L, Walk back to the left end
7,Rewind,y,y,Rewind,L, Walk back to the left end
8,Rewind,#,#,GoB,R, Left end reached: head for B
9,GoB,0,0,GoB,R, Skip A
10,GoB,x,x,GoB,R, Skip A
11,GoB,c,c,InB,R, Step into B
12,InB,y,y,InB,R, Skip digits of B already marked
13,InB,0,y,GoA,L, Mark the next digit of B, then cancel a digit of A
14,InB,e,e,AddQ,R, All of B is marked: one more B fits into A
15,GoA,0,0,GoA,L, Walk back to the left end
16,GoA,y,y,GoA,L, Walk back to the left end
17,GoA,c,c,GoA,L, Walk back to the left end
18,GoA,x,x,GoA,L, Walk back to the left end
19,GoA,#,#,FindA,R, Left end reached: find the first unused digit of A
20,FindA,x,x,FindA,R, Skip digits of A already used
21,FindA,0,x,GoB,R, Cancel one digit of A
22,FindA,c,c,Unmark,R, A is used up: work out the remainder
23,AddQ,0,0,AddQ,R, Skip the quotient so far
24,AddQ,#,0,ResetB,L, Add 1 to the quotient
25,ResetB,0,0,ResetB,L, Walk back over the quotient
26,ResetB,e,e,ResetY,L, Back at e: restore B
27,ResetY,y,0,ResetY,L, Turn y back into 0
28,ResetY,c,c,Rewind,L, B restored: start the next round
29,Unmark,y,y,Unmark,R, Find the last marked digit of B
30,Unmark,0,0,LastY,L, Past the marks: step back onto the last one
31,Unmark,e,e,LastY,L, Past the marks: step back onto the last one
32,LastY,y,0,CleanL,L, That mark found no digit of A: remove it
33,CleanL,y,y,CleanL,L, Walk back to the left end
34,CleanL,c,c,CleanL,L, Walk back to the left end
35,CleanL,x,x,CleanL,L, Walk back to the left end
36,CleanL,#,#,Clean,R, Left end reached: clean up
37,Clean,x,#,Clean,R, Erase A
38,Clean,c,#,Clean,R, Erase c
39,Clean,y,r,Clean,R, Each remaining mark is one unit of the remainder
40,Clean,0,#,Clean,R, Erase the unused part of B
41,Clean,e,e,Done,R, Done: remainder before e, quotient after it
