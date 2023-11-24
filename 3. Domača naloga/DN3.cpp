#include <iostream>
#include <cmath>

double arctan(double x,int n) {
    double vrednost = 0;
    for (int i = 0; i <= n; i++) {
        vrednost = vrednost + (pow(-1, i) * (pow(x, 2 * i + 1) / (2 * i + 1)));
    }
    return vrednost;
    
}

double enačba(double x, int n) {
    double vrednost = exp(3 * x) * arctan(x/2, n);
    return vrednost;
}

int main() {
    double const pi = 3.14159265;

    double a = 0;
    double b = pi/4;

    int razdelek = 1000000; 
    double h = (b-a)/razdelek;
    int n = 30; 

    double seštevek = 0;
    for (auto i = a; round(1000000 * i) <= round(1000000 * b); i = i + h) { 
        if (i != a and round(1000000 * i) != round(1000000 * b)) {
            seštevek = seštevek + 2* enačba(i, n);
        }
        else {
            seštevek = seštevek + enačba(i, n);
        }
    }
    double rešitev = (b - a) / (2 * razdelek) * seštevek;
    std::cout << rešitev << std::endl;
    
    return 0;
}
