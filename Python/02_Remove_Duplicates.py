# Python Proficiency - 2) You are given a string, remove all the duplicates and print the unique string. Use loop in the python.

def remove_duplicates_with_loop(input_string: str) -> str:
    """
    Removes duplicate characters from a string using a loop, preserving first-occurrence order.
    """
    unique_chars = []
    
    # Use a for loop to iterate through every character in the string
    for char in input_string:
        # Check if the character is NOT already in our list of unique characters
        if char not in unique_chars:
            unique_chars.append(char)
            
    # Join the list of unique characters back into a single string
    return "".join(unique_chars)

# --- Test Cases ---
# test_string_1 = "programming"
# print(remove_duplicates_with_loop(test_string_1)) 
# test_string_2 = "data analysis"
# print(remove_duplicates_with_loop(test_string_2))