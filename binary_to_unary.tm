Name = Binary to Unary
Description = Converts a binary number into unary (I marks)

#How it works (lines starting with #> are the machine's explanation)
#> Converts a binary number into unary: 101 (5) becomes IIIII.
#>
#> How it works:
#> 1. Start runs to the end of the number and writes a separator s; the unary result grows to the right of s.
#> 2. Dec subtracts 1 from the binary number (like binary decrement), then AppendU adds one I to the result and BackU returns.
#> 3. When the decrement borrows past the left end, the number has reached 0: ZeroClean erases the binary digits and the separator, leaving only the I marks.
#>
#> Output for 101 is five I marks.

#The tape alphabet: every symbol that may appear on the tape
Tape_Alphabet = 0,1,s,I,#,?

#Blank Symbol of tape
Blank_Symbol = #

#Maps to any symbol
Any_Symbol_Wild_Card = ?

#Initial input String
Input = 101

#Initial head position on input string, count starts with 0
Position = 0

#Set of States
States = Start,Dec,Append,AppendU,BackU,ZeroClean,Done

#Initial State
Initial_State = Start

#Set of accepted final states after which machine halts
Final_States = Done

Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Shift,	Comment
1,Start,0,0,Start,R, Run to the end of the number
2,Start,1,1,Start,R, Run to the end of the number
3,Start,#,s,Dec,L, Write the separator s, then subtract 1
4,Dec,0,1,Dec,L, 0 - 1: write 1 and borrow from the left
5,Dec,1,0,Append,R, 1 minus 1 is 0: subtracted one, now add an I
6,Dec,#,#,ZeroClean,R, Borrow past the left end: the number is used up
7,Append,0,0,Append,R, Walk right to the separator
8,Append,1,1,Append,R, Walk right to the separator
9,Append,s,s,AppendU,R, Step into the result
10,AppendU,I,I,AppendU,R, Skip the marks already written
11,AppendU,#,I,BackU,L, Add one I to the result
12,BackU,I,I,BackU,L, Walk back over the result
13,BackU,s,s,Dec,L, Back at the separator: subtract 1 again
14,ZeroClean,1,#,ZeroClean,R, Erase the binary digits (all 1s after the final borrow)
15,ZeroClean,s,#,Done,R, Erase the separator; the head is on the result
