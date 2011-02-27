#include <stdio.h>

void main()
{
  int n, x;  
  printf("enter number of loops:");
  scanf("%i", &n);
  
  for(x = 0; x < n; x++)
    printf("incremeneted: %i\n", x);    
};