import sympy as sp
import sys

header_default = """
#pragma once

typedef long double (*DerivativeFunc)(long double, long double);

extern DerivativeFunc derivatives[];

void _(); //  Satisfy compiler warnings

"""

# The empty array will be replaced automatically later, and is only a placeholder in the current context
source_default = """
#include <math.h>
#include "derivatives.h"

DerivativeFunc derivatives[] = {}; 
void _() { pow(0, 1); } // Satisfy compiler warnings

"""
function = sys.argv[1]
depth = eval(sys.argv[2])
# Define variable and function
x = sp.symbols('x')
f = sp.sympify(function) # From the commant line argument

# Compute derivatives symbolically
derivatives = [f]
for i in range(1, depth+1):  
    derivatives.append(sp.diff(derivatives[-1], x))

c_code = [sp.ccode(d) for d in derivatives]
#print(c_code)
c_code = [code.replace("e", "M_E") for code in c_code]
#print(c_code)
enumerated = list(enumerate(c_code, start=1))
#print(enumerated)
#enumerated.pop(0)
#print(enumerated)

function_names_list = "{f1, " # we need a filler for the first spot - because later on, main.c will attempt to find f1 at derivatives[1]
for i, code in enumerated: # if I don't ask for `code` too, it will split it up wrong
    function_names_list += f"f{i}, "
function_names_list = function_names_list[:-2]
function_names_list += "};"



with open("derivatives.h", "w") as header:
    with open("derivatives.c", "w") as source:
        header.write(header_default) # replacing the 100 
        source.write(source_default.replace("{}", function_names_list))
#print("done writng header")


with open("derivatives.h", "a") as header:
    with open("derivatives.c", "a") as source:
        #print("opened")
        for i, code in enumerated:
            #parameters = "long double x" + (", long double y" if "y" in code.split() else "")
            parameters = "long double x, long double y"
            #print(parameters)
            header.write(f"\nlong double f{i}({parameters});\n")
            source.write(f"\nlong double f{i}({parameters}) {{\n\treturn ({code});\n}}\n")