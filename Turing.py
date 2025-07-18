import sys
import json
#This code has been written in a single file so that
#Further a structured programming approch is taken over
#OO on account of simplicity and ease of understanding
#and given the complexcity of this code

'''
This code is a Turing machine simulator. On a high level it reads 
a file in this format and then executes the same.

The motivation of this code is that existing Turing machine simulators 
make a number of assumptions about the TUring machine such as naming convention
of states, not having multiple halt states, assuming the blank charecter on tape,
assuming the read head can move only left or right and cant stay stationary, input 
alphabet and tape alphabet are the same etc.

This application is a command line turing machine that takes the input file as an argument
and then execturs the same.

The general structure of the file is as follows:
1. Read the file into list of lines
2. Parse the list of lines and remove any comments (starting with #) or blanks
3. Convert the residual file into a dictionary for turing machine of the structure

Name = Add Two Uniary Numbers
Description = Adds Two uniary Numbers

#The initial input alphabet
Tape_Alphabet = 0,c,#,x,d,?

#Blank Symbol of tape
Blank_Symbol = #

#Initial input String
Input = 00c00

#Initial head position on input string, count starts with 0
Position=0

#Maps to any symbol
Any_Symbol_Wild_Card =?

#Set of States
States = Q0,Q1,Q2,Q3,Q4,Q5

#Initial State
Initial_State = Q0

#Set of accepted final states after which machine halts
Final_States = Q5

Shift = Left,Right,No_Shift

Left_Shift_Symbol = Left
Right_Shift_Symbol = Right
No_Shift_Symbol = No_Shift

#State Transition Table
S.No,   Current_State,	Input_Alphabet,		Output_Alphabet,		New_State,	Left_Right_No_Sift
1,Q0,0,x,Q1,Right
2,Q1,0,0,Q1,Right
3,Q1,c,c,Q2,Right
4,Q2,0,0,Q2,Right
5,Q2,#,0,Q3,Left
6,Q3,0,0,Q3,Left
7,Q3,c,c,Q4,Left
8,Q4,0,0,Q4,Left
9,Q4,x,x,Q0,Right
10,Q0,c,#,Q5,Right

4. Validate the Turing machine for static errors such as undefined states, alphabets etc
5. Execute the Turing machine
'''

#In an ideal world these would have gone into a mapping file 
#or a constants or a config file. However in interest of
#keeping code in one file we are making them constants

'''
The key to split key value pairs in line
'''
LINE_SPLIT_CHAR = '='

'''
The number of entries in key value pair
'''
LINE_SPLIT_PARTS = 2

'''
Key will be the first part in the split
'''
LINE_SPLIT_PART_KEY = 0

'''
Value will be the second part in the split
'''
LINE_SPLIT_PART_VALUE = 1

'''
The name of the turing machine
'''
TURING_MACHINE_NAME_KEY = 'Name'

'''
Description of the turing machine
'''
TURING_MACHINE_DESCRIPTION = 'Description'

'''
The blank symbol of the tape
'''
BLANK_SYMBOL = 'Blank_Symbol'

'''
The initial input of the tape
'''
INPUT = "Input"

'''
The position of the head on the tape
'''
POSITION = "Position"

'''
The initial state of the turing machine
'''
INITIAL_STATE = "Initial_State"

ANY_SYMBOL_WILD_CARD = "Any_Symbol_Wild_Card"

'''
The symbol that is used to represent the left shift in the turing machine
'''
LEFT_SHIFT_SYMBOL ="Left_Shift_Symbol"

'''
The symbol that is used to represent the right shift in the turing machine
'''
RIGHT_SHIFT_SYMBOL = "Right_Shift_Symbol"

'''
The symbol that is used to represent the no shift in the turing machine
'''
NO_SHIFT_SYMBOL = "No_Shift_Symbol"

'''
The  set of keys that will be simple key value pairs in the turing machine
'''
turing_machine_simple_key_names = [TURING_MACHINE_NAME_KEY, TURING_MACHINE_DESCRIPTION,
                                   BLANK_SYMBOL,BLANK_SYMBOL,INPUT,INITIAL_STATE,
                                   POSITION,ANY_SYMBOL_WILD_CARD, LEFT_SHIFT_SYMBOL,
                                   RIGHT_SHIFT_SYMBOL, NO_SHIFT_SYMBOL]

#The undergiven keys will be arrays in the file

'''
The set of alphabet in the tape, blank symbol and the initial input
are expected to be part of this alphabet and shall be validated
'''
TAPE_ALPHABET = "Tape_Alphabet"

'''
The complete set of states of the turing machine. The initial state, 
final state and the states in the state transition table are expected
to be part of this set of states
'''
STATES = "States"

'''
The array of final states, if any of these states are encountered the turing
mahine will halt
'''
FINAL_STATES = "Final_States"

'''
This contains the keys that will be assumed to be arrays in
the input file for the turing machine.
'''
turing_machine_array_key_names = [TAPE_ALPHABET,STATES,FINAL_STATES]

'''
The seperator of the array
'''
ARRAY_SEPERATOR = ","

#These are the column headers for the state transition table
'''
The Serial number of the state transition table
'''
STATE_TABLE_HEADER_ENTRY_STARTS_WITH = "S.No"

'''
The seperator for state transtion table columns
'''
STATE_TRANSITION_ENTRY_SEPERATOR = ","

'''
The dictionary key for the state transition table in the turing machine
'''
STATE_TRANSITION_TABLE = "State_Transition_Table"

'''
The column number for Serial number in the state transition table
'''
S_NO_COLUMN = 0

'''
The column number for current state in the state transition table
'''
CURRENT_STATE_COLUMN = 1

'''
The column number for current alphabet in the state transition table
'''
CURRENT_ALPHABET_COLUMN =2

'''
The column number for new alphabet in the state transition table
'''
NEW_ALPHABET_COLUMN=3

'''
The column number for new state in the state transition table
'''
NEW_STATE_COLUMN= 4

'''
The column number for shift direction in the state transition table
'''
SHIFT_COLUMN = 5

'''
The key name for new alphabet
'''
NEW_ALPHABET = "New_Alphabet"

'''
The key name for new state
'''
NEW_STATE = "New_State"

'''
The key name for Shift direction
'''
SHIFT = "Shift"

'''
The current state of the turing machine
'''
CURRENT_STATE = "Current_State"

'''
The tape of turing machine
'''
TAPE = "Tape"

'''
Current position on the tape
'''
CURRENT_POSITION = "Current_Position"

COLOR_FOR_CURRENT_TAPE_HEAD = "\033[31m"
COLOR_TO_RESET = "\033[0m"

'''
Character to print when prnting tape head
'''
WHITE_SPACE = " "

'''
Chaaracter to print when prnting tape head
'''
TAPE_HEAD_MARKET = "^"

'''
Number of columns expected in each row of state transition table
'''
NUMBER_OF_COLUMNS_IN_STATE_TRANSITION_TABLE = 6

def read_file_into_list(file_path:str)->list:
    """
    Reads the contents of a file and returns a list of its lines.
    The comments in the file are expected to begin with #
    This method will not check the structure of the file. 
    As the file to be read is a Turing machine file it is expected to 
    be small in size and hence reading the entire file into memory is acceptable.

    Args:
        file_path (str): The path to the file to be read.

    Returns:
        list: A list containing each line from the file as a string.
    """
    #Open the file in read mode and read all lines into a list
    with open(file_path, 'r') as f:
        #The with ensures the file is properly closed after reading
        #Hence no need to explicitly close the file or exception handeling
        return f.readlines()


def remove_comments_and_empty_lines_from_list(lst:list[str])->list[str]:
    """
    Removes comment lines (starting with '#') and empty lines from a list of strings.

    Args:
        lst (list): List of strings.

    Returns:
        list: A new list containing only non-comment, non-empty lines, 
        stripped of leading/trailing whitespace.
    """
    new_list = []
    for line in lst:
        # Check if the line does not start with '#' and is not empty after stripping whitespace
        if not line.startswith("#") and line.strip():
            # Add the cleaned line to the new list
            new_list.append(line.strip())
    return new_list


def add_turing_machine_element_to_dictionary(turing_machine_dictionary:dict, key:str, value:str):
    #In this code we do all the magic number and string code.
    #In an ideal world this mapping should be done in a config file
    #However as we want to keep things in one file we will use constants
    if(key in turing_machine_simple_key_names):
        #If the key is a simple key then we add it to dictionay as a key value pair
        #Things like inital state, name 
        turing_machine_dictionary[key] = value
    elif(key in turing_machine_array_key_names):
        turing_machine_dictionary[key] = value.split(ARRAY_SEPERATOR)


def add_or_get_state_transition_table_node(turing_machine_dictionary:dict)->dict:
    """
    Retrieves the state transition table node from the given Turing machine dictionary.
    If the state transition table does not exist, it initializes an empty dictionary for it.

    Args:
        turing_machine_dictionary (dict): The dictionary representing the Turing machine.

    Returns:
        dict: The state transition table node from the Turing machine dictionary.

    Comments:
        - The state transition table is typically used to define the rules for state transitions in a Turing machine.
        - The function ensures that the state transition table exists in the dictionary before returning it.
    """
    if(turing_machine_dictionary.get(STATE_TRANSITION_TABLE) is None):
        #If the state transition table does not exist then we initialize it
        turing_machine_dictionary[STATE_TRANSITION_TABLE] = {}
        #And then return it
    return turing_machine_dictionary[STATE_TRANSITION_TABLE]


def add_or_get_current_node(state_transition_table:dict,current_state:str)->dict:
    """
    Retrieves the transition dictionary for the given current state from the state transition table.
    If the current state does not exist in the table, initializes it with an empty dictionary.

    Args:
        state_transition_table (dict): The dictionary representing the state transition table.
        current_state (str): The state whose transition dictionary is to be retrieved or initialized.

    Returns:
        dict: The transition dictionary associated with the current state.
    """
    #Check if the node for current state exists
    if(state_transition_table.get(current_state) is None):
        #if not then create it
        state_transition_table[current_state] = {}
    return state_transition_table[current_state]


def add_turing_machine_state_transition_entry_to_dictionary(turing_machine_dictionary:dict
                                                            , state_transition_entry:str):
    """
    Adds a state transition entry to the Turing machine's transition dictionary.
    This function parses a state transition entry string, extracts its components,
    and inserts the transition into the appropriate location in the Turing machine's
    state transition table. If the entry is a header or already exists, it will be ignored
    or raise an exception, respectively.
    Args:
        turing_machine_dictionary (dict): The dictionary representing the Turing machine's state transitions.
        state_transition_entry (str): The string containing the state transition entry to be added.
    Raises:
        Exception: If a transition for the given state and alphabet already exists.
    Returns:
        None
    """
    
    #Check if the entry is a header, if so return
    if(state_transition_entry.startswith(STATE_TABLE_HEADER_ENTRY_STARTS_WITH)):
        return
    
    #split the transtion entry into columns after removing spaces and tabs using
    #, as a seperator
    parts = state_transition_entry.strip().replace(" ","").replace("\t","").split(
        STATE_TRANSITION_ENTRY_SEPERATOR)
    
    #Check the number of entries are correct in the table
    if(len(parts) != NUMBER_OF_COLUMNS_IN_STATE_TRANSITION_TABLE):
        raise Exception("State transition entry does not have "
                        + str(NUMBER_OF_COLUMNS_IN_STATE_TRANSITION_TABLE)
                        + " elements for the state transition entry: " + state_transition_entry)
                    
    
    #Check if the state state transtion key exists in the json, if not create
    state_transition_table = add_or_get_state_transition_table_node(turing_machine_dictionary)
    
    #Check if the entry in the state transition exists for the current node exists
    #if not then create one
    current_state_node = add_or_get_current_node(state_transition_table,parts[CURRENT_STATE_COLUMN])
    #Check if the Current node has an entry for the alphabet
    #if not make an entry
    if(current_state_node.get(parts[CURRENT_ALPHABET_COLUMN])) is None:
        current_state_node[parts[CURRENT_ALPHABET_COLUMN]] = {
            NEW_ALPHABET:parts[NEW_ALPHABET_COLUMN],
            NEW_STATE:parts[NEW_STATE_COLUMN],
            SHIFT:parts[SHIFT_COLUMN]
        }
        #else raise an error because a given node and alphabet
        #can not have two entries
    else:
        raise Exception("State transition entry already exists for State: "
                        + parts[CURRENT_STATE_COLUMN] + " and Alphabet: " 
                        + parts[CURRENT_ALPHABET_COLUMN] )


def convert_list_into_dictionary(lst:list[str])->dict:
    """
    Converts the file read into the list into a dictionary that represents the Turing machine.
    The code parses through each line in file. 
    If the line is a seperator then it can be a simple argument or a key value pair
    If the line is not a key value pair it is assumed to be a state transition line
    The apprpopriate mapping function is called to handle the line
    Args:
       lst (list[str]): The clean lines read from the file
    Returns:
        dict: The Turing machine dictionary represntation
    """
    
    #initialize the turing machine dictionary to blank
    turing_machine_dictionary = {}
    #For each line in the list
    for line in lst:
        # split the line into parts using the '=' character as the delimiter
        parts = line.split(LINE_SPLIT_CHAR)
        # check if the line has exactly two parts
        if len(parts) == LINE_SPLIT_PARTS:
            # assign the first part to the key variable
            key = parts[LINE_SPLIT_PART_KEY].strip()  
            # assign the second part to the value variable  
            value = parts[LINE_SPLIT_PART_VALUE].strip()
            #now based on key we will get the structured value
            add_turing_machine_element_to_dictionary(turing_machine_dictionary, key, value)
        else:
            #This will be the case for the states
            add_turing_machine_state_transition_entry_to_dictionary(turing_machine_dictionary,line)
            
    return turing_machine_dictionary


def is_symbol_in_alphabet(alphabet:list[str],symbol:str)->bool:
    """
    Checks if the  symbol is in the alphabet
    Args:
        alphabet (str): The alphabet
        symbol (str): The blank symbol
    Returns:
        bool: True if the  symbol is in the alphabet, False otherwise
    """
    return symbol in alphabet


def input_in_alphabet(alphabet:list[str],input:str):
    """
    Checks if the input is in the alphabet
    Args:
        alphabet (str): The alphabet
        input (str): The input
    Returns:
        tuple(bool,str): A tuple containing a boolean indicating if the input is in the 
        alphabet and the character that is not in the alphabet
    """
    input_in_alphabet = True
    char = None
    for input_char in input:
        if(input_char not in alphabet):
            input_in_alphabet = False
            char = input_char
            break
    
    return (input_in_alphabet,char)


def is_given_state_in_states(states:list[str],initial_state:str):
    """
    Checks if the  state is in the states
    Args:
        states (str): The states
        initial_state (str): The initial state
    Returns:
        bool: True if the initial state is in the states, False otherwise
    """
    return initial_state in states


def is_state_list_in_states(states:list[str],states_to_check:str):
    """
    Checks if the list of states is in the states
    Args:
        states (str): The states
        states_to_check (str): The  states to be checked
    Returns:
        tuple(bool,str): A tuple containing a boolean indicating if the state(s) is in the 
        states  and the state that is not in the states
    """
    
    final_states_in_states = True
    state = None
    for current_state in states_to_check:
        if(current_state not in states):
            final_states_in_states = False
            state = current_state
            break
    
    return (final_states_in_states,state)


def is_valid_state_transition_table(turing_machine_dictionary:dict):
    state_transition_table = turing_machine_dictionary[STATE_TRANSITION_TABLE]
    for current_state in state_transition_table.keys():
        #Check if the current state is in states
        if(is_given_state_in_states(turing_machine_dictionary[STATES],current_state) == False):
            return (False,current_state+" not in " + str(turing_machine_dictionary[STATES]))

        #Find the transition table for this state
        partial_state_transition_table = state_transition_table[current_state]
        for current_alphabet in partial_state_transition_table.keys():
            #Check if the current alphabet is in the alphabet
            if(is_symbol_in_alphabet(turing_machine_dictionary[TAPE_ALPHABET],current_alphabet) == False):
                return (False,current_alphabet+" not in " + str(turing_machine_dictionary[TAPE_ALPHABET])
                                                                +"for state "+current_state)
            #Find the values for new transtion
            current_state_alphabet_transtion = partial_state_transition_table[current_alphabet]
            
            new_alphabet = current_state_alphabet_transtion[NEW_ALPHABET]
            new_state = current_state_alphabet_transtion[NEW_STATE]
            shift_direction = current_state_alphabet_transtion[SHIFT]
            
            
            #Check new alphabet in turing machine
            if(is_symbol_in_alphabet(turing_machine_dictionary[TAPE_ALPHABET],new_alphabet) == False):
                return (False,new_alphabet+" not in " + str(turing_machine_dictionary[TAPE_ALPHABET])
                                                            +"for state "+current_state
                                                            +" and alphabet "+current_alphabet)
            #if the new state is in states
            if(is_given_state_in_states(turing_machine_dictionary[STATES],new_state) == False):
                return (False,new_state+" not in " + str(turing_machine_dictionary[STATES])
                                                            +"for state "+current_state
                                                            +" and alphabet "+current_alphabet)
            #Check shift direction
            shift_array = [
                turing_machine_dictionary[LEFT_SHIFT_SYMBOL],
                turing_machine_dictionary[RIGHT_SHIFT_SYMBOL],
                turing_machine_dictionary[NO_SHIFT_SYMBOL]
            ]
            if(shift_direction not in shift_array):
                return (False,shift_direction+" not in " + str(shift_array)
                                                            +"for state "+current_state
                                                            +" and alphabet "+current_alphabet)     
            
    return (True,None)


def validate_turing_machine(turing_machine_dictionary:dict):
    """
    Validates the structure and contents of a Turing machine definition provided as a dictionary.
    The function performs the following checks:
    1. Ensures the blank symbol is present in the tape alphabet.
    2. Verifies that all input symbols are included in the tape alphabet.
    3. Checks that the initial state is listed among the defined states.
    4. Validates that all final states are included in the set of states.
    5. Checks the correctness of the transition table, including states, 
    input/output alphabet, next state, and direction.
    Parameters:
        turing_machine_dictionary (dict): 
            A dictionary containing the Turing machine specification. Expected keys include:
            - TAPE_ALPHABET: List of symbols allowed on the tape.
            - BLANK_SYMBOL: The symbol representing a blank cell on the tape.
            - INPUT: The input string or list of symbols to be processed.
            - STATES: List of all possible states.
            - INITIAL_STATE: The starting state of the machine.
            - State Transition graph
    Raises:
        TypeError: If any of the validation checks fail, with a descriptive error message.
    """
    #check blank symbol is in the alphabet
    if(is_symbol_in_alphabet(turing_machine_dictionary[TAPE_ALPHABET]
                                   ,turing_machine_dictionary[BLANK_SYMBOL]) == False):
        raise TypeError("Blank symbol is not in the alphabet")
    
    #check if any symbol in the input is not in the alphabet
    if(is_symbol_in_alphabet(turing_machine_dictionary[TAPE_ALPHABET]
                                ,turing_machine_dictionary[ANY_SYMBOL_WILD_CARD]) == False):
        raise TypeError("Any symbol is not in the alphabet")
    
    #check input is in the alphabet
    input_in_alphabet_status = input_in_alphabet(turing_machine_dictionary[TAPE_ALPHABET]
                                          ,turing_machine_dictionary[INPUT])
    if(input_in_alphabet_status[0] == False):
        raise TypeError("Input "+input_in_alphabet_status[1]+" is not in the alphabet "
                        +str(turing_machine_dictionary[TAPE_ALPHABET]))
    
    #check initial state is in States
    if(is_given_state_in_states(turing_machine_dictionary[STATES],
                                  turing_machine_dictionary[INITIAL_STATE]) == False):
        raise TypeError("Initial state " + turing_machine_dictionary[INITIAL_STATE]
                        +" is not in the states "+str((turing_machine_dictionary[STATES])))
        
    #Check Final States are in states
    final_states_in_states_status = is_state_list_in_states(turing_machine_dictionary[STATES],
                                                             turing_machine_dictionary[FINAL_STATES])
    
    if(final_states_in_states_status[0] == False):
        raise TypeError("Final state "+final_states_in_states_status[1]+" is not in the states "
                        +str(turing_machine_dictionary[STATES]))
        
    #Check tranition table states, input alphabet, output alphabet, next state, and direction
    #are correct
    state_transition_validation_status = is_valid_state_transition_table(turing_machine_dictionary)
    if(state_transition_validation_status[0] == False):
        raise TypeError("State transition table is not valid. "+state_transition_validation_status[1])


def execute_to_next_state(turing_machine_dictionary:dict):
    """
    Executes a single transition of the Turing machine, updating its state, tape, and head position.
    Args:
        turing_machine_dictionary (dict): 
            A dictionary representing the current configuration of the Turing machine. 
            Expected keys include:
                - CURRENT_STATE: The current state of the machine.
                - TAPE: The tape as a string.
                - CURRENT_POSITION: The current head position (as a stringified integer).
                - STATE_TRANSITION_TABLE: The state transition table (dict).
                - BLANK_SYMBOL: The symbol representing a blank cell on the tape.
    Raises:
        Exception: If the current state or current alphabet is not found in the state transition table.
    Side Effects:
        - Updates the turing_machine_dictionary in-place:
            - Sets the new state.
            - Writes the new alphabet to the tape at the current position.
            - Moves the head left, right, or keeps it in place.
            - Expands the tape with blank symbols if the head moves beyond the tape boundaries.
    """
    
    #Find the current state and the current alphabet of the turing machine
    current_state = turing_machine_dictionary[CURRENT_STATE]
    current_alphabet = turing_machine_dictionary[TAPE][int(turing_machine_dictionary[CURRENT_POSITION])]
    #For the given current state and alpabet we see the transition in the table
    state_transition_table = turing_machine_dictionary[STATE_TRANSITION_TABLE]
    #if the state of state+ alphabet do not exist then raise an exception
    effective_alphabet = current_alphabet
    
    if(state_transition_table.get(current_state) is None):
        raise Exception("Current state "+current_state+" not in state transition table")
    
    if(state_transition_table[current_state].get(current_alphabet) is None):
        if(state_transition_table[current_state].get(turing_machine_dictionary[ANY_SYMBOL_WILD_CARD]) is None):
            raise Exception("Current alphabet "+current_alphabet+
                            " not in state transition table for state (including any character) "
                            +current_state)
        else:
            effective_alphabet = turing_machine_dictionary[ANY_SYMBOL_WILD_CARD]
    
            
    #get the new state, alphabet and shift direction
    current_state_transition = state_transition_table[current_state][effective_alphabet]
    new_state = current_state_transition[NEW_STATE]
    new_alphabet = current_state_transition[NEW_ALPHABET]
    shift_direction = current_state_transition[SHIFT]
    #set the values in the turing machine dictionary
    turing_machine_dictionary[CURRENT_STATE] = new_state
    tape = turing_machine_dictionary[TAPE]
    current_position = int(turing_machine_dictionary[CURRENT_POSITION])
    #String concatination in python
    tape =tape[:current_position] +new_alphabet + tape[current_position+1:]
    turing_machine_dictionary[TAPE] = tape
    shift_direction = current_state_transition[SHIFT]
    #set the direction of the head by setting the current position
    if(shift_direction == turing_machine_dictionary[RIGHT_SHIFT_SYMBOL]):
        turing_machine_dictionary[CURRENT_POSITION] = str(int(turing_machine_dictionary[CURRENT_POSITION]) + 1)
    elif(shift_direction == turing_machine_dictionary[LEFT_SHIFT_SYMBOL]):
        turing_machine_dictionary[CURRENT_POSITION] = str(int(turing_machine_dictionary[CURRENT_POSITION]) - 1)
    elif(shift_direction == turing_machine_dictionary[NO_SHIFT_SYMBOL]):
        pass
    #If we reach begeining of the tape or the end of the tape then we expand the tape
    #This is done by adding the blank symbol at the beginning or end of the tape
    #if we are at start of the tape then we add the blank symbol at the beginning
    if(int(turing_machine_dictionary[CURRENT_POSITION]) == -1):
        tape = turing_machine_dictionary[BLANK_SYMBOL] + tape
        turing_machine_dictionary[TAPE] = tape
        turing_machine_dictionary[CURRENT_POSITION] = "0"
    #if we are at the end of the tape then we add the blank symbol at the end
    if(int(turing_machine_dictionary[CURRENT_POSITION]) == len(turing_machine_dictionary[TAPE])):
        tape = tape + turing_machine_dictionary[BLANK_SYMBOL]
        turing_machine_dictionary[TAPE] = tape


def get_turing_machine_print_string(turing_machine_dictionary:dict):
    """
    Generates a formatted string representation of the current state of a Turing machine.
    Args:
        turing_machine_dictionary (dict): 
            A dictionary containing the Turing machine's current state, tape, and head position.
            Expected keys:
                - CURRENT_STATE: The current state of the Turing machine (str).
                - TAPE: The tape as a string.
                - CURRENT_POSITION: The current position of the tape head (int or str convertible to int).
                - COLOR_FOR_CURRENT_TAPE_HEAD: ANSI color code for highlighting the tape head (str).
                - COLOR_TO_RESET: ANSI color code to reset formatting (str).
    Returns:
        tuple:
            - print_string (str): A string showing the current state and tape, with the tape head highlighted.
            - head_position (int): The number of characters before the tape head (used for formatting output).
    Comments:
        - Highlights the tape head using provided color codes.
        - Also provides the position of the tape head in the output string.
    """
    #Find the current state, tape and position of the head
    current_state = turing_machine_dictionary[CURRENT_STATE]
    tape = turing_machine_dictionary[TAPE]
    position =  int(turing_machine_dictionary[CURRENT_POSITION])
    
    #The current position of the head is highlighted in the tape
    tape_char = COLOR_FOR_CURRENT_TAPE_HEAD + tape[position]+COLOR_TO_RESET
    print_tape = tape[:position]+tape_char+ tape[position+1:]
    print_string = current_state+" "+print_tape
    #Also find the location of the head in the tape
    head_position = len(current_state) + 1 + position  
    return(print_string,head_position)


def print_turing_machine(turing_machine_dictionary):
    """
    Prints the current state and tape of the Turing machine, highlighting the tape head position.
    Args:
        turing_machine_dictionary (dict): The dictionary representing the Turing machine.
    """
    print_string,head_position = get_turing_machine_print_string(turing_machine_dictionary)
    print(print_string)
    print(WHITE_SPACE*head_position+TAPE_HEAD_MARKET)


def execute_turing_machine(turing_machine_dictionary):
    """
    Executes a Turing machine simulation using the provided configuration dictionary.
    Args:
        turing_machine_dictionary (dict): 
            A dictionary containing the Turing machine's configuration and state. 
            Expected keys include:
                - INITIAL_STATE: The starting state of the Turing machine.
                - FINAL_STATES: A list or set of halting states.
                - INPUT: The initial tape input.
                - POSITION: The starting position of the tape head.
                - CURRENT_STATE: (will be set) The current state of the machine.
                - TAPE: (will be set) The current tape contents.
                - CURRENT_POSITION: (will be set) The current position of the tape head.
    Side Effects:
        - Updates the turing_machine_dictionary with the current state, tape, and position.
        - Prints the Turing machine's state at each step.
    Behavior:
        - Initializes the Turing machine's state, tape, and position.
        - Iteratively executes transitions until a halting state is reached.
        - Prints the Turing machine's state before and after execution.
    """
    # Initialize the current state from the initial state
    # Set up the tape and position from the input and starting position
    # Loop until a halting state is reached
    # Print the Turing machine's state at each step
    # Execute the transition to the next state
    # Break the loop if the current state is a halting state
    # Print the final state of the Turing machine
    
    #Before we start executing we initialise the Turning machine
    # We set current state of tape, position and current state
    # to the inputs we have received
    intial_state = turing_machine_dictionary[INITIAL_STATE]
    halt_states = turing_machine_dictionary[FINAL_STATES]
    current_state = intial_state
    turing_machine_dictionary[CURRENT_STATE] = current_state
    input = turing_machine_dictionary[INPUT]
    tape = input
    turing_machine_dictionary[TAPE] = tape
    position = turing_machine_dictionary[POSITION]
    current_position = position
    turing_machine_dictionary[CURRENT_POSITION] = current_position

    while(True):
        #Print the current state of the Turing machine
        print_turing_machine(turing_machine_dictionary)
        #execute the next state transition
        execute_to_next_state(turing_machine_dictionary)
        #Is the machine in halted state? If so break
        if(is_given_state_in_states(halt_states,turing_machine_dictionary[CURRENT_STATE]) == True):
            break
    #Print final state of the Turing machine before termination
    print_turing_machine(turing_machine_dictionary)
    
    print("Turning Machine : "+turing_machine_dictionary[TURING_MACHINE_NAME_KEY])
    print("Turning Machine Description : "+turing_machine_dictionary[TURING_MACHINE_DESCRIPTION])
    print("Turing Machine has halted in state: "+ turing_machine_dictionary[CURRENT_STATE])
    print("Initial Input    :   "+ turing_machine_dictionary[INPUT])
    print("Final Output     :   "+ turing_machine_dictionary[TAPE])

def run(turing_machine_file:str=None):
    
    file_lines = read_file_into_list(turing_machine_file)
    file_lines = remove_comments_and_empty_lines_from_list(file_lines)
    turing_machine_dictionary = convert_list_into_dictionary(file_lines)
    validate_turing_machine(turing_machine_dictionary)
    print(json.dumps(turing_machine_dictionary,indent=4))
    execute_turing_machine(turing_machine_dictionary)
    
    
def main():
    file_path = "/home/gaurav/code/add.tm"
    run(file_path)



if __name__ == "__main__":
    if len(sys.argv) > 1:
        run(sys.argv[1])
    else:
        print("Please Pass file Name as an argument")
        