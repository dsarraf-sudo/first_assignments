#!/bin/bash

# Loop from 1 to 100
for (( i=1; i<=100; i++ ))
do
    # Check if multiple of both 3 and 5 first
    # because if we check 3 first, '15' would print 'Fizz' and skip the rest
    if (( i % 3 == 0 && i % 5 == 0 )); then
        echo "FizzBuzz"
    
    # Check if multiple of 3
    elif (( i % 3 == 0 )); then
        echo "Fizz"
    
    # Check if multiple of 5
    elif (( i % 5 == 0 )); then
        echo "Buzz"
    
    # If none of the above, print the number
    else
        echo $i
    fi
done
