#include <stdio.h>

void foo();
void abc();
int main()
{
    int i=0,k;
    for(k=1;k<10;k++){
        i=i+1;
        printf("i=%d",i);
    }
    foo();
    abc();
    return 0;

}
void foo(){
    int i=10;
    i=i+1;

}
void abc(){
    int i=100;
    i--;

}
