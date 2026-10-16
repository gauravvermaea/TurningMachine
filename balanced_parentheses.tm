Name = Balanced Parentheses
Description = Decides whether every ( has a matching )

#How it works (lines starting with #> are the machine's explanation)
#> Decides whether a string of parentheses is balanced, halting in Accept or Reject: (()()) is balanced, (() and ())( are not.
#>
#> How it works:
#> 1. Find moves right to the first ) not yet matched and crosses it off (X).
#> 2. Match moves left to the nearest ( not yet matched and crosses it off too. If there is none, that ) has no partner: Reject.
#> 3. When Find reaches the end, CheckLeft walks back looking for a ( that was never matched: if it finds one, Reject; otherwise Accept.
#>
#> Matching each ) with the nearest ( before it is exactly how a stack would do it.

#The tape alphabet: every symbol that may appear on the tape
Tape_Alphabet = (,),X,#,?

#Blank Symbol of tape
Blank_Symbol = #

#Maps to any symbol
Any_Symbol_Wild_Card = ?

#Initial input String
Input = (()())

#Initial head position on input string, count starts with 0
Position = 0

#Set of States
States = Find,Match,CheckLeft,Accept,Reject

#Initial State
Initial_State = Find

#Set of accepted final states after which machine halts
Final_States = Accept,Reject

Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Shift,	Comment
1,Find,(,(,Find,R, Look for the next )
2,Find,X,X,Find,R, Skip matched pairs
3,Find,),X,Match,L, Found a ): cross it off and look for its (
4,Find,#,#,CheckLeft,L, End reached: check for unmatched (
5,Match,X,X,Match,L, Skip matched pairs
6,Match,(,X,Find,R, Found its partner: cross it off
7,Match,#,#,Reject,N, A ) with no ( before it
8,CheckLeft,X,X,CheckLeft,L, Walk back over matched pairs
9,CheckLeft,(,(,Reject,N, A ( that was never closed
10,CheckLeft,#,#,Accept,N, Every parenthesis was matched
