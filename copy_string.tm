Name = Copy a String
Description = Duplicates a string of a's and b's: w becomes w s w

#How it works (lines starting with #> are the machine's explanation)
#> Makes a copy of a string of a's and b's after it: ab becomes absab (the original, a separator s, the copy).
#>
#> How it works:
#> 1. Init runs to the end and writes the separator s.
#> 2. Next marks the next character of the original (A or B) and remembers it in the state: CarryA or CarryB.
#> 3. That state runs to the end of the copy and writes the character there; Back returns to the last marked character.
#> 4. When Next reaches s, every character has been copied: Restore turns the marks back into a and b and halts.
#>
#> This is the building block for many other machines, which need a working copy of their input.

#The tape alphabet: every symbol that may appear on the tape
Tape_Alphabet = a,b,A,B,s,#,?

#Blank Symbol of tape
Blank_Symbol = #

#Maps to any symbol
Any_Symbol_Wild_Card = ?

#Initial input String
Input = abb

#Initial head position on input string, count starts with 0
Position = 0

#Set of States
States = Init,Back,Next,CarryA,CarryB,Restore,Done

#Initial State
Initial_State = Init

#Set of accepted final states after which machine halts
Final_States = Done

Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Shift,	Comment
1,Init,a,a,Init,R, Run to the end of the string
2,Init,b,b,Init,R, Run to the end of the string
3,Init,#,s,Back,L, Write the separator s
4,Back,a,a,Back,L, Walk back
5,Back,b,b,Back,L, Walk back
6,Back,s,s,Back,L, Walk back
7,Back,A,A,Next,R, Found the last copied character: take the next one
8,Back,B,B,Next,R, Found the last copied character: take the next one
9,Back,#,#,Next,R, At the start: take the first character
10,Next,a,A,CarryA,R, Mark this a and carry a copy to the end
11,Next,b,B,CarryB,R, Mark this b and carry a copy to the end
12,Next,s,s,Restore,L, Reached s: everything is copied
13,CarryA,a,a,CarryA,R, Run to the end
14,CarryA,b,b,CarryA,R, Run to the end
15,CarryA,s,s,CarryA,R, Run to the end
16,CarryA,#,a,Back,L, Write the a, then go back
17,CarryB,a,a,CarryB,R, Run to the end
18,CarryB,b,b,CarryB,R, Run to the end
19,CarryB,s,s,CarryB,R, Run to the end
20,CarryB,#,b,Back,L, Write the b, then go back
21,Restore,A,a,Restore,L, Turn the mark back into a
22,Restore,B,b,Restore,L, Turn the mark back into b
23,Restore,#,#,Done,R, All restored: halt at the start
