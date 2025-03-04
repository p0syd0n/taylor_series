#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <math.h>
#include "derivatives.h"

long long factorial(int n) {
  if (n == 0) return 1;
  long long result = 1;
  for (int i = 1; i <= n; ++i) {
      result *= i;
  }
  return result;
}

int main(int argc, char *argv[]) {
  long double result = 0;
  
  // Check command line arguments
  assert(argc == 5);
  assert(atoi(argv[1]) >= 0);
  assert(atoi(argv[2]) >= 0);
  assert(atoi(argv[3]) >= 0);
  assert(atoi(argv[4]) >= 0);
  
  long double x_initial_condition = atoi(argv[1]);
  long double y_initial_condition = atoi(argv[2]);
  long double desired_value_x = atoi(argv[3]);
  int depth = atoi(argv[4]);
  
  // Initialize result with the initial condition y(0)
  result += y_initial_condition;
  
  // Compute Taylor series expansion
  for (int i = 1; i <= depth; i++) { // Start from 1, go up to depth
    //printf("Term %d\n", i);
    result += (derivatives[i](x_initial_condition, y_initial_condition) / factorial(i)) * pow((desired_value_x - x_initial_condition), i);
  }
  
  //printf("Done computing,\n");
  printf("%Lf\n", result);
  return 0;
}
