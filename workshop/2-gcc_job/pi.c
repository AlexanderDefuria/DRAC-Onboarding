#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define SEED time(NULL)

int main() {
    srand(SEED);
    int i, count, n;
    double x, y, z, pi;
    
    n = 1000000;
    
    count = 0;
    for(i = 0; i < n; ++i) {
        x = (double)rand() / RAND_MAX;
        y = (double)rand() / RAND_MAX;
        z = x * x + y * y;
        if(z <= 1) count++;

        if (i % 10000 == 0) {
            pi = (double)count / i * 4;
            printf("Approximate PI = %g\n", pi);
        }
    }

    return 0;
}
