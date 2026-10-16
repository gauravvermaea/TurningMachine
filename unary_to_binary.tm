Name = Unary to Binary
Description = Converts a unary number (I marks) into binary

#How it works (lines starting with #> are the machine's explanation)
#> Converts a unary number, written as I marks, into binary: IIIII (5) becomes 101.
#>
#> How it works:
#> 1. Setup and Init0 write a separator s and a binary counter 0 to the left of the input.
#> 2. For each I, FindI crosses it off (x) and Inc adds 1 to the counter, carrying to the left like binary increment.
#> 3. When no I is left, Cleanup erases the marks and the separator, leaving only the binary number.
#>
#> Output for IIIII is 101 (followed by erased cells).

#The tape alphabet: every symbol that may appear on the tape
Tape_Alphabet = I,x,s,0,1,#,?

#Blank Symbol of tape
Blank_Symbol = #

#Maps to any symbol
Any_Symbol_Wild_Card = ?

#Initial input String
Input = IIIII

#Initial head position on input string, count starts with 0
Position = 0

#Set of States
States = Start,Setup,Init0,ToUnary,FindI,BackToSep,Inc,Cleanup,Done

#Initial State
Initial_State = Start

#Set of accepted final states after which machine halts
Final_States = Done

Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Shift,	Comment
1,Start,I,I,Setup,L, Step left of the input to build the counter
2,Start,#,0,Done,N, No marks at all: the answer is 0
3,Setup,#,s,Init0,L, Write the separator s
4,Init0,#,0,ToUnary,R, Start the binary counter at 0
5,ToUnary,0,0,ToUnary,R, Walk right over the counter
6,ToUnary,1,1,ToUnary,R, Walk right over the counter
7,ToUnary,s,s,FindI,R, Step over the separator
8,FindI,x,x,FindI,R, Skip marks already counted
9,FindI,I,x,BackToSep,L, Count this mark: cross it off
10,FindI,#,#,Cleanup,L, Every mark counted: clean up
11,BackToSep,x,x,BackToSep,L, Walk back to the separator
12,BackToSep,s,s,Inc,L, Back at the separator: add 1 to the counter
13,Inc,1,0,Inc,L, 1 plus 1 is 10: write 0 and carry left
14,Inc,0,1,ToUnary,R, 0 plus 1 is 1: done adding
15,Inc,#,1,ToUnary,R, Carry past the left end: new leading 1
16,Cleanup,x,#,Cleanup,L, Erase the crossed-off marks
17,Cleanup,s,#,Done,L, Erase the separator; the head is on the binary number
