#include "ctype.h"

int kisprint(int c)
{
    return (c >= 32 && c <= 126) ? 1 : 0;
}
