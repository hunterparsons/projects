// Name       : main.cpp
// Programmer : Hunter Parsons
// Date       : 11/4/2024

#include <iostream>
#include "head.h"
int main() {
	double x;
	int n;
	std::cout << "Please enter your base : ";
	std::cin >> x;
	std::cout << "Please enter your power : ";
	std::cin >> n;
	std::cout << x << " to the power of " << n << " is " << recursivePower(x, n) << std::endl; 

	return 0;
}