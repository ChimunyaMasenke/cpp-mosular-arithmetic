//
//  main.cpp
//  Calculator
//
//  Created by Nchimunya Masenke on 12/09/2025.
//

#include <iostream>
#include <cmath>
using namespace std;

double Addition(double, double);
double Substraction(double, double);
double Multiplication(double, double);
double Division(double, double);

int main(){
    double num1 = 0, num2 = 0;
    int option;
    cout<<"1. Addition \n2. Substract \n3. Multiplication \n4. Division \nEnter option: ";
    cin>>option;
    cout<<"Enter num1: ";
    cin>>num1;
    cout<<"Enter num2: ";
    cin>>num2;
    
    switch(option){
        case 1: cout<<"Sum: " <<Addition(num1, num2) <<endl;
            break;
        case 2: cout<<"Difference: " <<Substraction(num1, num2) <<endl;
            break;
        case 3: cout<<"Product: " <<Multiplication(num1, num2) <<endl;
            break;
        case 4: cout<<"Quotient: " <<Division(num1, num2) <<endl;
            break;
        default: cerr<<"Invalid option! \n";
            break;
    }
    return 0;
}

double Addition(double num1, double num2){
    double sum = num1 + num2;
    return sum;
}

double Substraction(double num1, double num2){
    double difference = num1 - num2;
    return difference;
}

double Multiplication(double num1, double num2){
    double product = num1*num2;
    return product;
}

double Division(double num1, double num2){
    double quotient = num1/num2;
    return quotient;
}
