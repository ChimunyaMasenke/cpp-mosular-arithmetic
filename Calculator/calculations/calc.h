//
//  calc.h
//  Calculator
//

#include <iostream>
#include <cmath>
using namespace std;

extern "C" {
double Addition(double, double);
double Substraction(double, double);
double Multiplication(double, double);
double Division(double, double);
int Factorial(int);
double Power(double, double);
}