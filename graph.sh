#!/bin/bash

# Define the output data file
data_file="data.txt"
rm -f $data_file  # Remove any old data file if it exists

# Define your x values (these could be passed as arguments to this script)
x_values=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40)  # Or, use: x_values=("$@") if passed as command-line arguments

# Loop through x values, run your script, and capture the corresponding y value
for x in "${x_values[@]}"
do
  # Run your script to get the y value for each x
  y=$(bash go.sh $x "e**x" 5 148.413159103 9)  # Replace './my_script.sh' with the path to your actual script

  # Append the x and y pair to the data file
  echo "$x $y" >> $data_file
done

