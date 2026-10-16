Name = Palindrome Checker
Description = Decides whether a string of a's and b's reads the same backwards

#How it works (lines starting with #> are the machine's explanation)
#> Decides whether a string of a's and b's is a palindrome (reads the same both ways), halting in Accept or Reject.
#>
#> How it works:
#> 1. Start erases the first character and remembers it in the state: HaveA or HaveB.
#> 2. That state runs to the end of the string, and CheckA or CheckB compares the last character with the remembered one.
#> 3. If they match, the last character is erased too and Back returns to the new first character. If they differ, Reject.
#> 4. When nothing (or a single character) is left, every pair matched: Accept.
#>
#> The empty string and single letters are palindromes. For abba it halts in Accept; for abab in Reject.

#The tape alphabet: every symbol that may appear on the tape
Tape_Alphabet = a,b,#,?

#Blank Symbol of tape
Blank_Symbol = #

#Maps to any symbol
Any_Symbol_Wild_Card = ?

#Initial input String
Input = abba

#Initial head position on input string, count starts with 0
Position = 0

#Set of States
States = Start,HaveA,HaveB,CheckA,CheckB,Back,Accept,Reject

#Initial State
Initial_State = Start

#Set of accepted final states after which machine halts
Final_States = Accept,Reject

Left_Shift_Symbol = L
Right_Shift_Symbol = R
No_Shift_Symbol = N

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Shift,	Comment
1,Start,a,#,HaveA,R, Erase the first character and remember it was a
2,Start,b,#,HaveB,R, Erase the first character and remember it was b
3,Start,#,#,Accept,N, Nothing left: every pair matched
4,HaveA,a,a,HaveA,R, Run to the end
5,HaveA,b,b,HaveA,R, Run to the end
6,HaveA,#,#,CheckA,L, End reached: look at the last character
7,HaveB,a,a,HaveB,R, Run to the end
8,HaveB,b,b,HaveB,R, Run to the end
9,HaveB,#,#,CheckB,L, End reached: look at the last character
10,CheckA,a,#,Back,L, Last character is a too: erase it and go back
11,CheckA,b,b,Reject,N, First was a, last is b: not a palindrome
12,CheckA,#,#,Accept,N, The remembered a was the middle character
13,CheckB,b,#,Back,L, Last character is b too: erase it and go back
14,CheckB,a,a,Reject,N, First was b, last is a: not a palindrome
15,CheckB,#,#,Accept,N, The remembered b was the middle character
16,Back,a,a,Back,L, Walk back to the start
17,Back,b,b,Back,L, Walk back to the start
18,Back,#,#,Start,R, At the start: compare the next pair
