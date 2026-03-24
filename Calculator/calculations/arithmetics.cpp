#include "calc.h"

extern "C" {

  double Addition(double num1, double num2) {
    double sum = num1 + num2;
    return sum;
  }

  double Substraction(double num1, double num2) {
    double difference = num1 - num2;
    return difference;
  }

  double Multiplication(double num1, double num2) {
    double product = num1 * num2;
    return product;
  }

  double Division(double num1, double num2) {
    double quotient = num1 / num2;
    return quotient;
  }

  int Factorial(int num){
      if(num <= 1) return num;
      return num * Factorial(num - 1);
  }

  //Power function using cmath
  double Power(double base, double exponent){
      return pow(base, exponent);
  }

}

