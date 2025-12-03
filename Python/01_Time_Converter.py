# Python Proficiency - 1) Given number of minutes, convert it into human readable form.

def minutes_to_human_readable(minutes: int) -> str:
    """
    Converts a number of minutes into a human-readable string.
    Example: 130 becomes "2 hrs 10 minutes"
    """
    if not isinstance(minutes, int) or minutes < 0:
        # Handle invalid input
        return "Invalid input: Please provide a non-negative integer."

    hours = minutes // 60  # Integer division for hours
    remaining_minutes = minutes % 60 # Modulo for remaining minutes

    result_parts = []
    
    # Construct hours string
    if hours > 0:
        hr_str = "hr" if hours == 1 else "hrs"
        result_parts.append(f"{hours} {hr_str}")

    # Construct minutes string
    if remaining_minutes > 0:
        result_parts.append(f"{remaining_minutes} minutes")

    # Handle the 0 minutes edge case
    if not result_parts:
        return "0 minutes"

    return " ".join(result_parts)

# --- Test Cases ---
# print(minutes_to_human_readable(130))
# print(minutes_to_human_readable(60))
# print(minutes_to_human_readable(59))
# print(minutes_to_human_readable(0))