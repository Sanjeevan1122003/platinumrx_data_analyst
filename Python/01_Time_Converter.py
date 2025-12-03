def convert_minutes_to_hours_minutes(total_minutes):
    """
    Convert total minutes to hours and minutes format.
    
    Args:
        total_minutes (int): Total number of minutes
    
    Returns:
        str: Formatted string in "X hrs Y minutes" format
    """
    try:
        # Validate input
        if not isinstance(total_minutes, (int, float)):
            raise ValueError("Input must be a number")
        
        if total_minutes < 0:
            raise ValueError("Minutes cannot be negative")
        
        # Convert to integer
        total_minutes = int(total_minutes)
        
        # Calculate hours and minutes
        hours = total_minutes // 60
        minutes = total_minutes % 60
        
        # Format the output
        if hours == 0:
            return f"{minutes} minutes"
        elif minutes == 0:
            return f"{hours} hrs"
        else:
            return f"{hours} hrs {minutes} minutes"
    
    except ValueError as e:
        return f"Error: {e}"
    except Exception as e:
        return f"Unexpected error: {e}"


# Test the function
def test_time_converter():
    """Test cases for the time converter function"""
    test_cases = [
        (130, "2 hrs 10 minutes"),
        (60, "1 hrs"),
        (45, "45 minutes"),
        (0, "0 minutes"),
        (125, "2 hrs 5 minutes"),
        (1440, "24 hrs"),  # 24 hours
        (90, "1 hrs 30 minutes")
    ]
    
    print("Testing Time Converter:")
    print("=" * 40)
    
    for minutes, expected in test_cases:
        result = convert_minutes_to_hours_minutes(minutes)
        status = "✓ PASS" if result == expected else "✗ FAIL"
        print(f"{minutes:5} minutes -> {result:20} {status}")
    
    # Edge cases
    print("\nEdge Cases:")
    print("-" * 40)
    print("Negative input:", convert_minutes_to_hours_minutes(-10))
    print("Float input:", convert_minutes_to_hours_minutes(90.5))
    print("String input:", convert_minutes_to_hours_minutes("120"))


if __name__ == "__main__":
    # Run tests
    test_time_converter()
    
    # Example usage
    print("\n" + "=" * 40)
    print("Example Usage:")
    print("=" * 40)
    
    examples = [130, 65, 720, 15]
    for example in examples:
        result = convert_minutes_to_hours_minutes(example)
        print(f"{example} minutes = {result}")
    
    # Interactive mode
    print("\n" + "=" * 40)
    print("Interactive Mode:")
    print("=" * 40)
    
    try:
        user_input = input("Enter minutes to convert (or 'q' to quit): ")
        while user_input.lower() != 'q':
            if user_input.isdigit():
                minutes = int(user_input)
                result = convert_minutes_to_hours_minutes(minutes)
                print(f"{minutes} minutes = {result}")
            else:
                print("Please enter a valid number.")
            user_input = input("\nEnter minutes to convert (or 'q' to quit): ")
    except KeyboardInterrupt:
        print("\n\nProgram terminated by user.")