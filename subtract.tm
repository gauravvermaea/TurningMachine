Name = Subtracts two Unirary Numbers
Description = Subtracts two uniary numbers.

#How it works (lines starting with #> are the machine's explanation)
#> Subtracts two unary numbers. The input is # A c B #, and the result is B - A (B must be at least A): #00000c000000000000# is 12 - 5.
#>
#> How it works:
#> 1. Q0 marks the next 0 of A with x and Q1 runs right to the separator c.
#> 2. Q2 skips the digits of B that are already cancelled (x) and cancels the next 0 of B with x.
#> 3. Q3 and Q4 walk back to the last x in A, and Q0 repeats.
#> 4. When A is used up (Q0 reads c), Q5 erases B's cancelled digits; the 0s that remain are the answer. It halts in Q6.
#>
#> Output is #xxxxxc#####0000000#: seven 0s, and 12 - 5 = 7.
#> If A is bigger than B the machine gets stuck in Q2 at the blank after B.

#The initial input alphabet
Tape_Alphabet = 0,c,#,x,?

#Blank Symbol of tape
Blank_Symbol = #

#Initial input String
Input = #00000c000000000000#

#Initial head position on input string, count starts with 0
Position=1

#Maps to any symbol
Any_Symbol_Wild_Card =?


#Set of States
States = Q0,Q1,Q2,Q3,Q4,Q5,Q6

#Initial State
Initial_State = Q0

#Set of accepted final states after which machine halts
Final_States = Q6

Left_Shift_Symbol = Left
Right_Shift_Symbol = Right
No_Shift_Symbol = No_Shift

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Sift,	Comment
1,Q0,0,x,Q1,Right, Mark the next digit of A as x
2,Q1,0,0,Q1,Right, Skip the rest of A
3,Q1,c,c,Q2,Right, Step over c into B
4,Q2,x,x,Q2,Right, Skip digits of B already cancelled
5,Q2,0,x,Q3,Left, Cancel one digit of B, then turn back
6,Q3,x,x,Q3,Left, Walk back over the cancelled digits
7,Q3,c,c,Q4,Left, Step back over c
8,Q4,0,0,Q4,Left, Walk back over A
9,Q4,x,x,Q0,Right, Found the last x: move on to the next digit of A
10,Q0,c,c,Q5,Right, A is used up: go and clean up B
11,Q5,x,#,Q5,Right, Erase a cancelled digit of B
12,Q5,0,0,Q6,Left, First remaining 0 starts the answer: halt