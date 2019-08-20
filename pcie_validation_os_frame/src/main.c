#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "pcie_case_help.h"



int main(int argc, char *argv[])
{
    uint8_t i = 0;

    printf("argc: %d\n", argc);
    for(i=0; i<argc; i++)
    {
        printf("argv[%d]: %s\n", i, argv[i]);
    }
    if(argc < 2)
    {
        printf("argc num error\n");
        return -1;
    }
    else
    {
        if(strcmp(argv[1], "help") == 0)//help no enum device
        {
            show_case();
        }
        else//run cases
        {
            printf("\n\n");
            if(strcmp(argv[1], "all_case") == 0)
            {
                run_all_case(pcie_test_case_list, argc, argv);
            }
            else
            {
                run_specific_case(pcie_test_case_list, argc, argv);
            }
        }

    }
    return 0;
}
