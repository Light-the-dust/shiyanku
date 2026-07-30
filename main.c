#include <stdio.h>
int main()
{
    int i, j;
    /* 打印表头*/
    for (i = 1; i <= 9; i++)
        printf(" %4d", i);
    printf("    |");
    printf("\n");
    for (i = 0; i <= 48; i++)
        printf("%c", '_');
    printf("|___");
    printf("\n");


    for (i=1;i<=9;i++)
    { for (j=1;j<=9;j++)
        if(i<=j)
            printf(" %4d",i*j);
        else printf("     ");
        printf("    |  %d",i);
        printf("\n");
    }
    printf("\n");
    return 0;
}
