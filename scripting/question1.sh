#!/bin/bash

fib() {
    local n=$1
    
    # Seed values
    local a=0
    local b=1

    if [ "$n" -eq 0 ]; then
        echo $a
        return
    elif [ "$n" -eq 1 ]; then
        echo $b
        return
    fi

    # Iterative calculation for n > 1
    # Fn = Fn-1 + Fn-2
    for (( i=2; i<=n; i++ ))
    do
        fn=$((a + b))
        a=$b
        b=$fn
    done

    echo $b
}

# Taking user input or command line argument
if [ -z "$1" ]; then
    read -p "Enter the value of n: " input_n
else
    input_n=$1
fi

# Call the function
result=$(fib $input_n)
echo "The $input_n Fibonacci number is: $result"


