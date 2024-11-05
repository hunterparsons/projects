// Name       : powerOfX.cpp
// Programmer : Hunter Parsons
// Date       : 10/31/2024

#include "head.h"
#include <cmath>
bool isPowerOfX(int n, int x) {
    if (n == 0 && x == 0) {
        return true;
    }
    if (n == 1) {
        return true;
    } else if (n % x) {
        return false;
    } else if (n == 0) {
        return false;
    }
    return isPowerOfX(n / x, x);
}