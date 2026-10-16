Name = Square Root of a Unary Perfect Square
Description = Finds the square root of a perfect square written in unary

#How it works (lines starting with #> are the machine's explanation)
#> Finds the square root of a perfect square n written as n 0s: 000000000 is 9.
#>
#> It uses the fact that 1 + 3 + 5 + ... + (2k - 1) = k squared. The machine takes away 1, then 3, then 5, ... from n and counts how many times it can do so; that count is the square root.
#>
#> How it works:
#> 1. Init writes a separator e after n; the count k is kept after e as k symbols.
#> 2. Each round takes away 2k + 1 digits of n: Start cancels one digit (x), then for every k already counted (marked z in turn) Find1 and F2 cancel two more.
#> 3. When every k is marked, ResetK appends a new k (the count goes up by one) and unmarks them, and the next round begins.
#> 4. When a round starts and n has no digits left, the count is the answer: CleanX and SkipB erase everything except the k symbols and halt in Done.
#> If n is not a perfect square, a round runs out of digits half way and the machine halts in NotSquare.
#>
#> Output for 000000000 (9) is #########kkk: three k symbols, the square root of 9.

#The tape alphabet: every symbol that may appear on the tape
Tape_Alphabet = 0,e,x,k,z,#,?

#Blank Symbol of tape
Blank_Symbol = #

#Maps to any symbol
Any_Symbol_Wild_Card = ?

#Initial input String
Input = 000000000

#Initial head position on input string, count starts with 0
Position = 0

#Set of States
States = Init,Rewind,Start,ToK,InK,GoLeft,Find1,F2,ResetK,CleanX,SkipB,Done,NotSquare

#Initial State
Initial_State = Init

#Set of accepted final states after which machine halts
Final_States = Done,NotSquare

Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Shift,	Comment
1,Init,0,0,Init,R, Walk right over n
2,Init,#,e,Rewind,L, Write the separator e after n, then go back
3,Rewind,0,0,Rewind,L, Walk back to the left end
4,Rewind,x,x,Rewind,L, Walk back to the left end
5,Rewind,#,#,Start,R, Left end reached: start a round
6,Start,x,x,Start,R, Skip digits already taken away
7,Start,0,x,ToK,R, Take away 1 (the +1 of 2k + 1)
8,Start,e,e,CleanX,L, n is used up exactly: the count k is the square root
9,ToK,0,0,ToK,R, Walk right to the count
10,ToK,x,x,ToK,R, Walk right to the count
11,ToK,e,e,InK,R, Step into the count
12,InK,z,z,InK,R, Skip counts already used this round
13,InK,k,z,GoLeft,L, Use the next count: take away two more digits
14,InK,#,k,ResetK,L, Round complete: the count goes up by one
15,GoLeft,z,z,GoLeft,L, Walk back to the left end
16,GoLeft,k,k,GoLeft,L, Walk back to the left end
17,GoLeft,e,e,GoLeft,L, Walk back to the left end
18,GoLeft,0,0,GoLeft,L, Walk back to the left end
19,GoLeft,x,x,GoLeft,L, Walk back to the left end
20,GoLeft,#,#,Find1,R, Left end reached: find the first unused digit
21,Find1,x,x,Find1,R, Skip digits already taken away
22,Find1,0,x,F2,R, Take away the first of two digits
23,Find1,e,e,NotSquare,N, Ran out of digits mid-round: not a perfect square
24,F2,0,x,ToK,R, Take away the second of two digits
25,F2,e,e,NotSquare,N, Ran out of digits mid-round: not a perfect square
26,ResetK,z,k,ResetK,L, Unmark the counts for the next round
27,ResetK,k,k,ResetK,L, Walk back over the count
28,ResetK,e,e,Rewind,L, Count ready: go back for the next round
29,CleanX,x,#,CleanX,L, Erase the used digits
30,CleanX,#,#,SkipB,R, Left end reached: go back to e
31,SkipB,#,#,SkipB,R, Skip the erased cells
32,SkipB,e,#,Done,R, Erase e; the head now stands on the answer: halt
