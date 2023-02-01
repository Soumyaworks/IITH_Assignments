#include <stdio.h>

int main()
{
    int num1, num2, i, gcd;

    printf("\nEnter two integers: ");
    scanf("%d %d", &num1, &num2);

    for(i=1; i <= num1 && i <= num2; i++){
        if(num1%i==0 && num2%i==0)			// updating the value of i as it increases with loop, gcd since it divides both the 2 numbers
            gcd = i;
    }

    printf("G.C.D of %d and %d = %d", num1, num2, gcd);

    return 0;
}
