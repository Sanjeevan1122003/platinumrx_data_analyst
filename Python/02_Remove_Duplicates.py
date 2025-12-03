def remove_duplicates(input_string):
    """
    Remove duplicate characters from a string while preserving order.
    
    Args:
        input_string (str): The input string
    
    Returns:
        str: String with duplicate characters removed
    """
    try:
        # Handle None or empty input
        if input_string is None:
            return ""
        
        if not isinstance(input_string, str):
            # Try to convert to string
            input_string = str(input_string)
        
        # Method 1: Using dictionary to preserve order (Python 3.7+)
        seen = {}
        result_chars = []
        
        for char in input_string:
            if char not in seen:
                seen[char] = True
                result_chars.append(char)
        
        result = ''.join(result_chars)
        
        return result
    
    except Exception as e:
        return f"Error: {e}"


def remove_duplicates_alternative(input_string):
    """
    Alternative method using set() and list comprehension.
    Note: This doesn't preserve order in Python versions < 3.7
    
    Args:
        input_string (str): The input string
    
    Returns:
        str: String with duplicate characters removed
    """
    if not input_string:
        return ""
    
    # For Python 3.7+, sets maintain insertion order
    return ''.join(dict.fromkeys(input_string))


def analyze_string(input_string):
    """
    Analyze the string and provide statistics about duplicates.
    
    Args:
        input_string (str): The input string
    
    Returns:
        dict: Analysis results
    """
    if not input_string:
        return {"original": "", "cleaned": "", "duplicates_removed": 0}
    
    cleaned = remove_duplicates(input_string)
    
    return {
        "original": input_string,
        "cleaned": cleaned,
        "original_length": len(input_string),
        "cleaned_length": len(cleaned),
        "duplicates_removed": len(input_string) - len(cleaned),
        "removed_percentage": round((1 - len(cleaned) / len(input_string)) * 100, 2) if input_string else 0
    }


def test_duplicate_remover():
    """Test cases for the duplicate remover function"""
    test_cases = [
        ("hello", "helo"),
        ("programming", "progamin"),
        ("aabbcc", "abc"),
        ("", ""),
        ("AAAAA", "A"),
        ("AbcDefAbc", "AbcDef"),
        ("123112233", "123"),
        ("Python is awesome!", "Python isawome!"),
        ("   spaces  ", " spac"),
        ("\t\ntabs\nand\nlines\t", "\t\nadlis")  # Includes special characters
    ]
    
    print("Testing Duplicate Remover:")
    print("=" * 60)
    print(f"{'Input':<25} {'Expected':<25} {'Result':<25} {'Status'}")
    print("-" * 60)
    
    all_passed = True
    for input_str, expected in test_cases:
        result = remove_duplicates(input_str)
        status = "✓ PASS" if result == expected else "✗ FAIL"
        if result != expected:
            all_passed = False
        
        # Display control characters properly
        display_input = repr(input_str)[1:-1] if input_str else "''"
        display_result = repr(result)[1:-1] if result else "''"
        display_expected = repr(expected)[1:-1] if expected else "''"
        
        print(f"{display_input:<25} {display_expected:<25} {display_result:<25} {status}")
    
    return all_passed


if __name__ == "__main__":
    # Run comprehensive tests
    print("DUPLICATE CHARACTER REMOVER")
    print("=" * 60)
    
    # Run tests
    tests_passed = test_duplicate_remover()
    
    print("\n" + "=" * 60)
    print("ADDITIONAL EXAMPLES AND ANALYSIS:")
    print("=" * 60)
    
    # Additional examples with analysis
    examples = [
        "Hello World!",
        "Data Analysis",
        "Python Programming",
        "Mississippi",
        "A man a plan a canal Panama"
    ]
    
    for example in examples:
        analysis = analyze_string(example)
        print(f"\nOriginal: '{example}'")
        print(f"Cleaned:  '{analysis['cleaned']}'")
        print(f"Length: {analysis['original_length']} → {analysis['cleaned_length']}")
        print(f"Duplicates removed: {analysis['duplicates_removed']} ({analysis['removed_percentage']}%)")
    
    # Interactive mode
    print("\n" + "=" * 60)
    print("INTERACTIVE MODE:")
    print("=" * 60)
    print("Enter strings to remove duplicates (or 'q' to quit)")
    
    try:
        while True:
            user_input = input("\nEnter a string: ").strip()
            
            if user_input.lower() == 'q':
                print("Goodbye!")
                break
            
            if user_input.lower() == '':
                print("Please enter a valid string or 'q' to quit.")
                continue
            
            result = remove_duplicates(user_input)
            analysis = analyze_string(user_input)
            
            print(f"\nResults:")
            print(f"  Original: '{user_input}'")
            print(f"  Without duplicates: '{result}'")
            print(f"  Stats: Removed {analysis['duplicates_removed']} characters")
            print(f"         ({analysis['original_length']} → {analysis['cleaned_length']} characters)")
    
    except KeyboardInterrupt:
        print("\n\nProgram terminated by user.")
    
    except Exception as e:
        print(f"\nAn error occurred: {e}")