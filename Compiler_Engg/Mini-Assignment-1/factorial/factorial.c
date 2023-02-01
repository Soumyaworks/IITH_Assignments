#include <stdio.h>

int factorial(int n){ 		// recursive function to calculate the factorial of a number
	if(n==1)
		return n;
	else
		return n*factorial(n-1);
}

int main(){
	int i,n,ans;
	n=5;
	ans=factorial(n);	// ans stores the value of factorial of 5
	printf("\nThe factorial of (n=5) = %d",ans);
	return 0;
}
