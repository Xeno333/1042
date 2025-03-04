#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define X_MIN -31000
#define X_MAX 31000
#define X_W 62000

#define Z_MIN -31000
#define Z_MAX 31000
#define Z_W 62000

#define ymax 128
#define continent_radius 30000



int* map = NULL;


inline long double max(long double a, long double b) {
    if (a >= b) return a;
    return b;
}
inline long double min(long double a, long double b) {
    if (a <= b) return a;
    return b;
}

int main() {
    map = (int*)malloc((size_t)X_W * (size_t)Z_W * sizeof(int));
    if (map == NULL) {
        printf("Mem allocation failed!\n");
        return 1;
    }

    unsigned long long q = 0;

    for (register long x = X_MIN, pointer = 0; x < X_MAX; x++) {
        for (register long z = Z_MIN; z < Z_MAX; z++, pointer++) {
            
            long double r = sqrtl((long double)x*(long double)x + (long double)z*(long double)z);
            float noise = 0;
            register int ny = 0;

            if (noise <= 0.9) {
                ny = noise * abs(noise) * (ymax);

                if (r > continent_radius) {
                    ny = ny - (max(0, min(ymax, ((long double)1/(long double)3) * (r - (long double)continent_radius))));
                }
            }

            map[pointer] = (int)floor(ny);

            q = q + (unsigned long long)ny;
        }

        // Status
        if (x % 1000 == 0)
            printf("%f%%\n", 100 * ((double)x-X_MIN) / X_W);
    }
    printf("100%%\n");

    printf("%llu\n", q);

    free(map);
    return 0;
}