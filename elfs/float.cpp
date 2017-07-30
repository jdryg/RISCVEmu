#include <stdio.h>

int main()
{
    float a, b;
    printf("Enter to floating point numbers separated with a space\n");
    scanf("%f %f", &a, &b);

    printf("a = %f\n", a);
    printf("b = %f\n", b);
    printf("a + b = %f\n", a + b);
    printf("a - b = %f\n", a - b);
    printf("a * b = %f\n", a * b);
    printf("b / a = %f\n", a / b);

    return 0;
}