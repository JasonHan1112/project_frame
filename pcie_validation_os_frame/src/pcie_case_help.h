#ifndef __PCIE_CASE_HELP_H__
#define __PCIE_CASE_HELP_H__

#include "stdio.h"
#include "stdint.h"


#define nd_printf printf
#define dbg_printf printf

typedef uint8_t (*CASE_FUNCTION_T)(char *pcie_dev, int argc, char* argv[]);

typedef struct pcie_test_case_list_t
{
    uint32_t vendor_device_id;
    const char* case_name;
    CASE_FUNCTION_T case_function;
}PCIE_TEST_CASE_LIST_T;


extern PCIE_TEST_CASE_LIST_T pcie_test_case_list[];

void show_case(void);
int run_case(PCIE_TEST_CASE_LIST_T *case_list, int argc, char* argv[]);
int run_specific_case(PCIE_TEST_CASE_LIST_T *case_list, int argc, char* argv[]);



#endif
