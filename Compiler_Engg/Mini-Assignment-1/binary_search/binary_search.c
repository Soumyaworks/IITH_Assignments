#include <stdio.h>
 

int binarySearch(int arr[], int left, int right, int key)		// recursive function to search for key inside array arr[]
{
    if (right >= left) {
        int mid = left + (right - left) / 2;

        if (arr[mid] == key)
            return mid;
 

        if (arr[mid] > key)
            return binarySearch(arr, left, mid - 1, key);
        return binarySearch(arr, mid + 1, right, key);
    }
 
    return -1;
}
 
int main()
{
    int array[] = { 100,200,488,500,600,700 };			// array consisting of 6 elements, sorted in ascending order
    int n = 6;
    int key = 488;
    int index = binarySearch(array, 0, n - 1, key);
    if(index == -1)
         printf("\nElement is not present in array");
    else
        printf("\nElement is present here: %d", index);
    return 0;
}
