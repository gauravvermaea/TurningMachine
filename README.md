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


# Wish List
1. Want to run in web
2. Want to bring the exeuction without scrolling the screen with a tape like tool moving and states changing while the current execution dumped to a log file for a nicer UX

Very descriptive and detailed. Works better than most of the projects I found out there.

# How To use
python3 Turing.py <path_turing_machine_file> <optional delay in seconds>

example

python3 Turing.py ./flib_bits.tm 1.0


python3 Turing.py ./flib_bits.tm 

The sample files are descriptive enough to use. The code is well documented to change.
