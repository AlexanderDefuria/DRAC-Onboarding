#include <stdio.h>

void printTriangle(int height) {
    for (int i = 1; i <= height; i++) {
        for (int j = 0; j < i; j++) {
            printf("*");
        }
        printf("\n");
    }
}

int main() {
    int height = 5;
    printTriangle(height);
    return 0;
}