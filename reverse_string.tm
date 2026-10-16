Name = Reverses a string
Description = Reverses a string

#How it works (lines starting with #> are the machine's explanation)
#> Reverses a string of a's and b's. The reversed copy is written after the original, which is erased: #aabb# becomes #####bbaa#.
#>
#> How it works:
#> 1. Q0 runs right to the end of the string.
#> 2. Q1 walks left to the rightmost character that has not been moved yet, marks it x and remembers it in the state: Q2 carries an a, Q3 carries a b.
#> 3. Q2 or Q3 runs right to the first blank and drops the character there. Q4 walks back to the marks and Q1 picks the next one.
#>    Characters are taken from the right and appended on the right, so the copy comes out reversed.
#> 4. When Q1 reaches the blank at the left end, Q5 erases the x marks and Q6 runs to the end of the result. It halts in Q7.
#>
#> Note: rule number 3 appears twice in this file; S.No is only a label, so the machine still works.

#The initial input alphabet
Tape_Alphabet = a,b,#,?,x

#Blank Symbol of tape
Blank_Symbol = #

#Initial input String
Input = #aabb#

#Initial head position on input string, count starts with 0
Position=1

#Maps to any symbol
Any_Symbol_Wild_Card =?

#Set of States
States = Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7

#Initial State
Initial_State = Q0

#Set of accepted final states after which machine halts
Final_States = Q7

#Shift of the head
Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Sift,	Comment
1, Q0,a,a,Q0,R, Run right to the end of the string
2, Q0,b,b,Q0,R, Run right to the end of the string
3, Q0,#,#,Q1,L, End reached: step back onto the last character
3, Q1,x,x,Q1,L, Skip characters that were already moved
4, Q1,a,x,Q2,R, Take an a (mark it x) and carry it right
5, Q1,b,x,Q3,R, Take a b (mark it x) and carry it right
6, Q1,#,#,Q5,R, Nothing left to take: go and clean up
7, Q2,a,a,Q2,R, Carry the a right
8, Q2,b,b,Q2,R, Carry the a right
9, Q2,x,x,Q2,R, Carry the a right
10,Q2,#,a,Q4,L, Drop the a at the end, then go back
11,Q3,a,a,Q3,R, Carry the b right
12,Q3,b,b,Q3,R, Carry the b right
13,Q3,x,x,Q3,R, Carry the b right
14,Q3,#,b,Q4,L, Drop the b at the end, then go back
15,Q4,a,a,Q4,L, Walk back over the result
16,Q4,b,b,Q4,L, Walk back over the result
17,Q4,x,x,Q1,L, Back at the marks: look for the next character
18,Q5,x,#,Q5,R, Erase a mark
19,Q5,b,b,Q6,N, Reached the result: stop erasing
20,Q5,a,a,Q6,N, Reached the result: stop erasing
21,Q6,a,a,Q6,R, Run to the end of the result
22,Q6,b,b,Q6,R, Run to the end of the result
23,Q6,#,#,Q7,N, End of the result: halt