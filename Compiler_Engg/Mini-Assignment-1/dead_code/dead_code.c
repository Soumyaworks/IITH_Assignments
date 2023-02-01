#include <stdio.h>

int main(){
	
	int a,b,c,d,t;
	a=10;b=20;
	c=a+b;
	t=c;							// should be dead code, not used anywhere
	d=c+100;
	printf("The value of d =%d",d);
	
	if(1<2)
		printf("\nThis always gets executed");
	else
		printf("\nThis never gets executed");		// never reaches here, as 1<2 holds true always
	return 0;
}
