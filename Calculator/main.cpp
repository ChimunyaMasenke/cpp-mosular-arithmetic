#include "calc.h"

int main() {
  double num1 = 0, num2 = 0;
  int option;
  cout << "1. Addition \n2. Substract \n3. Multiplication \n4. Division \n5. "
          "Factorial \n"
          "\nEnter option: ";

  if (option != 5) {
    cin >> option;
    cout << "Enter num1: ";
    cin >> num1;
    cout << "Enter num2: ";
    cin >> num2;
  } else if (option == 5) {
    cout << "Enter a number: ";
    cin >> num1;
  }

  switch (option) {
  case 1:
    cout << "Sum: " << Addition(num1, num2) << endl;
    break;
  case 2:
    cout << "Difference: " << Substraction(num1, num2) << endl;
    break;
  case 3:
    cout << "Product: " << Multiplication(num1, num2) << endl;
    break;
  case 4:
    cout << "Quotient: " << Division(num1, num2) << endl;
    break;
  case 5:
    cout << "Factorial: " << Factorial(num1) << endl;
    break;
  default:
    cerr << "Invalid option! \n";
    break;
  }
  return 0;
}
