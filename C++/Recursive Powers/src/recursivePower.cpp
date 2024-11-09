// Name       : recursivePower.cpp
// Programmer : Hunter Parsons
// Date       : 11/4/2024

#include "head.h"
double recursivePower(double x, int n) {
    if (n == -1) {
        return 1/x;
    } else if (n == 0) {
        return 1;
    } else if (n == 1) {
        return x;
    }

    double halfPow = recursivePower(x, n / 2);

    if (n % 2) {
        if (n < 0) {
            return halfPow * halfPow * (1 / x);
        }
        return halfPow * halfPow * x; 
    } 
    return halfPow * halfPow;
}