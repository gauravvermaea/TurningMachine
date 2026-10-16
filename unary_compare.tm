Name = Compare Two Unary Numbers
Description = Compares unary A and B and halts in Less, Equal or Greater

#How it works (lines starting with #> are the machine's explanation)
#> Compares two unary numbers. The input is A c B, where A and B are runs of 0s: 000c00000 compares 3 with 5.
#> The answer is the state the machine halts in: Less (A < B), Equal or Greater (A > B).
#>
#> How it works:
#> 1. Start crosses off one digit of A (x) and InB crosses off one digit of B (y), then Back returns for the next pair.
#> 2. If B runs out while A still had a digit, A is bigger: Greater.
#> 3. When A runs out, CheckB looks at B: if a digit is left, A is smaller (Less); otherwise they are Equal.
#>
#> This shows a machine that answers a question with its final state rather than with the tape. For 000c00000 it halts in Less.

#The tape alphabet: every symbol that may appear on the tape
Tape_Alphabet = 0,c,x,y,#,?

#Blank Symbol of tape
Blank_Symbol = #

#Maps to any symbol
Any_Symbol_Wild_Card = ?

#Initial input String
Input = 000c00000

#Initial head position on input string, count starts with 0
Position = 0

#Set of States
States = Start,ToB,InB,Back,CheckB,Less,Equal,Greater

#Initial State
Initial_State = Start

#Set of accepted final states after which machine halts
Final_States = Less,Equal,Greater

Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Shift,	Comment
1,Start,0,x,ToB,R, Cross off one digit of A
2,Start,c,c,CheckB,R, A is used up: see what is left of B
3,ToB,0,0,ToB,R, Skip the rest of A
4,ToB,c,c,InB,R, Step into B
5,InB,y,y,InB,R, Skip digits of B already crossed off
6,InB,0,y,Back,L, Cross off the matching digit of B
7,InB,#,#,Greater,N, B ran out first: A is bigger
8,Back,y,y,Back,L, Walk back
9,Back,c,c,Back,L, Walk back
10,Back,0,0,Back,L, Walk back
11,Back,x,x,Start,R, Found the last x: take the next digit of A
12,CheckB,y,y,CheckB,R, Skip crossed-off digits of B
13,CheckB,0,0,Less,N, B has digits left: A is smaller
14,CheckB,#,#,Equal,N, Both ran out together: they are equal
