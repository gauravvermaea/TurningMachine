# TurningMachine
Command Line Turing Machine in Python
Created a Turning machine simulator that runs on command line.

The states, alphabet, input etc are all customizable.

There are no assumptions made in this code, which was a big problem for anything found online.

1. State names can be arbitrary
2. The tape is infinite
3. The blank symbol can be customized
4. The any match is availab;e
5. There can be more than one final states
6. There are pre execution checks (think comilation)
7. State is printed in each step
8. At the end there is output and execution summary
9. Alphabet is exeplictly defined and tape content, blank etc are sub sets
10. States are explictly defined and Transition table, initial state and final states have to be subset of them
11. No assumptions are made on any naming conventions
12. Left, Right and No Move are possible with custom notations
13. If you want you can have a delay to stat you can see how each state is changed
14. At each step the current state of machine, tape, tape head and trnasiton function are displayed so that you can do debugging
15. The xecution summary contains name, desciption, end state, input and output
16. Initial position of the head on the tape can be specified. This position can not be outside initial input, so if it needs to point outside then additional blanks need to be part of the input and the location needs to be specified. This is a limitation and shall be worked on.
17. Output is on command line
18. Code is modular and structured, no OO techniques have been used except from language constructs


19. Each rule can have a comment describing what it does, and each machine a "how it works" explanation (see below)

# Wish List
1. ~~Want to run in web~~ Done: see Turing Machine Studio below
2. ~~Want to bring the exeuction without scrolling the screen with a tape like tool moving and states changing while the current execution dumped to a log file for a nicer UX~~ Done: see Turing Machine Studio below

Very descriptive and detailed. Works better than most of the projects I found out there.

# How To use
python3 Turing.py <path_turing_machine_file> <optional delay in seconds> / debug

example

python3 Turing.py ./flip_bits.tm 1.0
python3 Turing.py add.tm debug



python3 Turing.py ./flip_bits.tm

The sample files are descriptive enough to use. The code is well documented to change.

# Rule comments and "how it works" explanations

A rule row may have a 7th column: a free-text comment saying what the rule does.
Everything after the sixth comma is the comment, so it keeps its spaces and may contain commas.

```
S.No, Current_State, Input_Alphabet, Output_Alphabet, New_State, Left_Right_No_Shift, Comment
1,Q0,0,x,Q1,R, Mark the next unused digit of A as x
```

Lines starting with `#>` are the machine's explanation, in plain text (`#>` alone is an empty line):

```
#> Inverts a binary string: every 0 becomes 1 and every 1 becomes 0.
#>
#> Q0 moves right flipping each bit; at the blank it stops in Q1.
```

`Turing.py` shows each rule's comment with every step and prints the explanation in the summary.
All example files have both. (An older copy of `Turing.py` would reject rule rows that have a comment column;
the `#>` lines are ordinary comments to it.)

# Examples

| File | What it does |
|---|---|
| add.tm / add_with_defaults.tm | Adds two unary numbers (`00c000` = 2 + 3); the second relies on the default settings |
| subtract.tm | Subtracts two unary numbers (B - A) |
| multiply.tm | Multiplies two unary numbers (`00c000` = 2 x 3), leaving only the product on the tape |
| flip_bits.tm | Inverts a binary string |
| alternate_0_1.tm | Writes 0101... until the end marker |
| reverse_string.tm | Reverses a string of a's and b's |
| halt_on_finding_first_a.tm | Two final states: halts in Found_a or Not_Found_a |
| one_step_halt.tm | One rule, showing the wildcard |
| three_state_busy_beaver.tm / four_state_busy_beaver.tm | Busy beavers (6 ones in 14 steps; 13 ones in 107 steps). Rule 8 of the 4-state machine is corrected to `D,1,0,A,R` (with `L` it never halts) |

# Turing Machine Studio (web version)

`turing_machine_studio.html` is the same simulator in the browser, as one self-contained file:
open it in any modern browser, no server or internet connection needed. It reads and writes the same `.tm` files.

- **Run & Debug**: compile with phase-by-phase output, step forward and back, run at any speed, go to any step,
  breakpoints, edit tape cells / head / state and the rules table (including comments) while running,
  a live **state diagram** that highlights each transition, a full log, and a **state trace** showing the run
  as a path through the diagram, and the **diagram at every step**: the full diagram once per step, one after
  another, showing the state it came from, the transition taken and the state it is in (downloadable as HTML)
- **Editor**: build a machine on a form (symbols and states as columns with +, rules with +, comments,
  "how it works" text), with a live state diagram; open a `.tm` file or an example; download the file or load it into the engine
- **Config & Defaults**, **Examples** (with explanations) and a **README** tab
- Click any state diagram to open it full screen (zoom, pan; on Run & Debug it keeps following the run with Step / Back / Run)
- Every problem explains itself on hover
- **Download report**: one HTML file with the whole run: result, machine, rules, the state diagram
  with a step player, every step with the tape, and the complete log
