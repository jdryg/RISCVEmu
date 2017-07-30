#include <stdio.h>
#include <malloc.h>

#define NUM_ITEMS 1024

int main()
{
    printf("Allocating %d integers...\n", NUM_ITEMS);

    int* p = (int*)malloc(sizeof(int) * NUM_ITEMS);
    
    printf("- Address = %p\n", p);

    printf("Assigning values to all integers...\n");
    for(int i = 0;i < NUM_ITEMS;++i) {
        *p++ = i;
    }
    printf("Done. Freeing memory...\n");
    
    free(p);

    return 0;
}