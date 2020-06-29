#include <stdlib.h>
#include <stdbool.h>
#include <stdio.h>

#define IS_ASCII(c) ((c) <= 0x8F)
#define IS_UTF8_START(c) (!((((c) & 0x80) == 0x80) && (((c) | 0xBF) == 0xBF)))

int main(int argc, char *argv[])
{
    int len = 80;
    int c;
    int i = 0;
    while ((c = getc(stdin)) != EOF)
    {
        if (IS_UTF8_START(c))
        {
            if (i > len && c != '\n')
            {
                putc('\n', stdout);
                i = 0;
            }
            putc(c, stdout);
            i++;
            // fprintf(stderr, "0x%X\n", c);
        }
        else
        {
            putc(c, stdout);
            i++;
        }
    }
    return 0;
}
