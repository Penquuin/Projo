#include <stdio.h>

#include "shrimp/shrimp.h"

int main()
{
    int x = 5;
    addfive(&x);

    printf("%d", x);

    return 0;
}
