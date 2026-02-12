#!/bin/bash

# Initialize variables
input_file=""
output_file=""
reverse_lines=false
swap_case=false
sub_a=""
sub_b=""
to_lower=false
to_upper=false

# 1. Parse Arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -i) input_file="$2"; shift 2 ;;
        -o) output_file="$2"; shift 2 ;;
        -v) swap_case=true; shift ;;
        -s) sub_a="$2"; sub_b="$3"; shift 3 ;;
        -r) reverse_lines=true; shift ;;
        -l) to_lower=true; shift ;;
        -u) to_upper=true; shift ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
done

# Check if input file exists
if [[ ! -f "$input_file" ]]; then
    echo "Error: Input file not found!"
    exit 1
fi

# 2. Process Text
# Start by reading the file
content=$(cat "$input_file")

# Apply Swap Case (lowercase <-> uppercase)
if [ "$swap_case" = true ]; then
    content=$(echo "$content" | tr '[:lower:][:upper:]' '[:upper:][:lower:]')
fi

# Apply Substitution (A_WORD -> B_WORD)
if [ -n "$sub_a" ]; then
    content=$(echo "$content" | sed "s/$sub_a/$sub_b/g")
fi

# Apply Lowercase conversion
if [ "$to_lower" = true ]; then
    content=$(echo "$content" | tr '[:upper:]' '[:lower:]')
fi

# Apply Uppercase conversion
if [ "$to_upper" = true ]; then
    content=$(echo "$content" | tr '[:lower:]' '[:upper:]')
fi

# Apply Line Reversal
if [ "$reverse_lines" = true ]; then
    content=$(echo "$content" | rev)
fi

# 3. Write to Output
echo "$content" > "$output_file"
echo "Processing complete. Check $output_file"
