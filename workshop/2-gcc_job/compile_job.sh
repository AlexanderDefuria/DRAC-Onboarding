#!/bin/bash
#SBATCH --time=00:15:00
#SBATCH --account=def-sponsor00

# Load the necessary module for the compiler
module load gcc

# Compile the C program
gcc -o my_program c_app.c

# Run the compiled program
./my_program