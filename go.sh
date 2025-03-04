#!/bin/bash

# Check if the number of arguments is less than 4
if [ $# -lt 4 ]; then
    echo "Usage: go.sh <depth> <function> <initial_condition_x> <initial_condition_y> <query>"
    echo "<depth> : integer, degree of Taylor polynomial (the more, the more accurate)"
    echo "<function> : the differential equation. Python function format. See help for more details"
    echo "<initial_condition_x> & <initial_condition_y> : the initial condition coordinates / point of tangency / anchor. To each his own terminology"
    echo "<query> : What you are looking to estimate. If you want f(5), type 5"
    echo "Use go.sh help for more help"
    exit 1
# Check if the user requested help
elif [ "$1" == "help" ]; then
    echo "This is a function value estimator, based off of a differential equation as well as a depth and an initial condition. Basically a Taylor Polynomial evaluator."
    echo "Depth is to what degree to do the polynomial (the higher the degree, the higher the accuracy) Eg, 4"
    echo "The function: enter the differential equation. Use python format. For example:"
    echo "x^2 = x**2"
    echo "x+2 = x+2"
    echo "x/2 = x/2"
    echo "x*2 = x*2"
    echo "x^(5x) = x**(5*x)"
    echo "Google it for more details."
    echo "Initial condition is the point of tangency, where we start evaluating. Eg, for (1, 2), type 1 2"
    echo "Query is what you want. You're estimating the function at a point. What's the x value of the point? Eg: 'I want f(5)' - type 5"
    exit 0
else
    # Run the Python and C code if the arguments are correct
    python3 derivatives.py $2 $1
    gcc -c derivatives.c -o derivatives.o
    gcc main.o derivatives.o -o main -lm
    ./main $3 $4 $5 $1
fi
