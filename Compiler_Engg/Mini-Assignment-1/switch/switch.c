#include <stdio.h>

int main() {

	  int n,i,j;
	  printf("\nEnter the value of n (1/2/any other) :");	// switches between 3 numbers : 1/2/ any other number given as user input
	  scanf("%d",&n);
	  switch (n){
	  	case 1 : printf("The value of n entered is 1");
	  		 break;
	  	case 2 : printf("The value of n entered is 2");
	  		break;
	  	default : printf("The value of n entered is anything other than 1 and 2");	// handles the case where the number is anything other than 1 and 2
	  }
	  return 0;
}
