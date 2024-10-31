// Name       : main.cpp
// Programmer : Hunter Parsons
// Date       : 10/31/2024
#include <iostream>
#include "head.h"
int main() {
	int n, x; // n is the number checked if it is a power of x;
	std::cout<<"Enter number you would like to check : ";
	std::cin>>n;
	std::cout<<"Enter base number : ";
	std::cin>>x;
	if (isPowerOfX(n,x)) {
		std::cout<<n<<" is a power of "<<x<<std::endl;
	} else {
		std::cout<<n<<" is not a power of "<<x<<std::endl;
	}

	return 0;
}