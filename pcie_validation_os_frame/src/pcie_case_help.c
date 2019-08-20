#include <string.h>
#include "pcie_case_help.h"

////////////////////////////////////
#include "case_file.h"
////////////////////////////////////


////////////////////////////////////////////////////////
#define MAX_PCIE_TEST_CASE 512 
PCIE_TEST_CASE_LIST_T pcie_test_case_list[MAX_PCIE_TEST_CASE] = 
#include "case_function.h"
////////////////////////////////////////////////////////

void show_case(void)
{
    return;
}

#define SAME_VENDOR_DEVICE_MAX_NUM  32
int run_all_case(PCIE_TEST_CASE_LIST_T *case_list, int argc, char* argv[])
{
    return 0;
}

int run_specific_case(PCIE_TEST_CASE_LIST_T *case_list, int argc, char* argv[])
{


    return 0;
}
