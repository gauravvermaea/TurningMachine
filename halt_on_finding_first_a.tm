Name = Halts after encountering first a or end of tape. 
Description = Halts the after finding first a or end of tape. If a is found state is Found_a if not found it is Not_Found_a

#How it works (lines starting with #> are the machine's explanation)
#> Searches the input from left to right for the letter a.
#>
#> Start skips b, c, d and e. On the first a it halts in Found_a; if it reaches the blank # first, it halts in Not_Found_a.
#> This shows a machine with two final states, where the state it halts in is the answer. The tape is not changed.
#>
#> For bcddddbbae it halts in Found_a after 9 steps.

#The initial input alphabet
Tape_Alphabet = a,b,c,d,e,#,?

#Blank Symbol of tape
Blank_Symbol = #

#Initial input String
Input = bcddddbbae

#Initial head position on input string, count starts with 0
Position=0

#Maps to any symbol
Any_Symbol_Wild_Card =?

#Set of States
States = Start,Found_a,Not_Found_a

#Initial State
Initial_State = Start

#Set of accepted final states after which machine halts
Final_States = Found_a,Not_Found_a

#Shift of the head
Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Sift,	Comment
1,Start,a,a,Found_a,R, Found an a: halt in Found_a
2,Start,b,b,Start,R, Skip b
3,Start,c,c,Start,R, Skip c
4,Start,d,d,Start,R, Skip d
5,Start,e,e,Start,R, Skip e
6,Start,#,#,Not_Found_a,R, End of the input with no a: halt in Not_Found_a
