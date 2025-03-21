#!/bin/bash

# Check if an argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <integer>"
    exit 1
fi

# Check if the argument is an integer
if ! [[ "$1" =~ ^-?[0-9]+$ ]]; then
    echo "Error: Argument is not an integer."
    exit 1
fi

# Square the input integer
input=$1
result=$((input * input))

# Print the result
echo "The square of $input is $result"