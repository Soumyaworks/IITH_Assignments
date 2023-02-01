#include <stdio.h>

int fibo(int n){				// recursive definition of fibonacci series, to find the nth fibonacci element
	if(n==0 || n==1){
		return n;
	}
	else{
		return fibo(n-1) + fibo(n-2);
	}
}
int main(){
	int n,ans;
	n=6;
	ans=fibo(n);
	printf("nth fibonacci element (here n=6): %d",ans);
	return 0;
}
