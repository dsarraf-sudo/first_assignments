#!/bin/bash

# Initialize variables
operation=""
numbers=()
debug=false

# 1. Parse Options
# o: requires an argument, n: requires an argument, d: no argument
while [[ $# -gt 0 ]]; do
    case "$1" in
        -o)
            operation="$2"
            shift 2
            ;;
        -n)
            shift
            # Capture all numbers until the next flag or end of arguments
            while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
                numbers+=("$1")
                shift
            done
            ;;
        -d)
            debug=true
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# 2. Debug Information
if [ "$debug" = true ]; then
    echo "User: $(whoami)"
    echo "Script: $(basename "$0")"
    echo "Operation: $operation"
    echo "Numbers: ${numbers[*]}"
fi

# 3. Perform Calculation
if [ ${#numbers[@]} -eq 0 ]; then
    echo "Error: No numbers provided."
    exit 1
fi

result=${numbers[0]}  

for (( i=1; i<${#numbers[@]}; i++ )); do
    current=${numbers[$i]}
    case "$operation" in
        +) result=$((result + current)) ;;
        -) result=$((result - current)) ;;
        "*") result=$((result * current)) ;;
        %) result=$((result % current)) ;;
        *) echo "Invalid operation: $operation"; exit 1 ;;
    esac
done

echo "Result: $result"
