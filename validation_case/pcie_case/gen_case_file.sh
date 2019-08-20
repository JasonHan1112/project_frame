#!/bin/bash

CASE_FILE=case_file.h
#auto generate case_file.h, add "#include "*.h""
function generate_case_file_h()
{
    echo -e "******insert #include \"...\" to $CASE_FILE******"
    rm $CASE_FILE
    touch $CASE_FILE
    echo -e "/*auto generate don't change if you don't know this file well*/\n" > $CASE_FILE

    #$1 case dir
    for file_name in `ls $1 | grep "\.h"` 
    do  
        include_file=`echo $file_name | awk '{a=sprintf("#include \"%s\"\n", $1); print a}'`
        echo $include_file
        echo -e "$include_file" >> $CASE_FILE
    done
    return 0
}



#filter string 
#1. find .l_[no common].*.h
#2. cut ".h"
REG_EXP=".*_.*\.h"
FILTER_FILE=".*_common.h"
CUT_STRING="\.h"
function filter_string()
{
    #1. filter all need *.h
    #2. filter .l_common.h
    #3. remove ".h"
    ret=`echo $1 | awk '/'$REG_EXP'/{print}' \
        | awk '!/'$FILTER_FILE'/{print}' \
        | awk -F ''$CUT_STRING'' '{print $1}'`
    echo $ret
}

#assemble string
function assemble_string()
{
    
    #echo -e "assemble_string: $1"
    ret=`echo $1 | awk '{s=sprintf("{%s, \"%s\", %s},", "VENDOR_DEVICE1", "'$1'", "'$1'"); print s}'`
    echo $ret
}

#parse xx_case.h, add items to case_function.h 
#add your case
#{vendorid_deviceid, "case_name", case_function} "case_name" must match case_function
CASE_FUNCTION=case_function.h
function insert_case_iterm()
{
    echo -e "******insert case iterm to $CASE_FUNCTION******"
    rm $CASE_FUNCTION
    touch $CASE_FUNCTION
    echo -e "/*auto generate don't change if you don't know this file well*/\n" > $CASE_FUNCTION
    echo -e "//{vendorid_deviceid, \"case_name\", case_function}, \"case_name\" must match case_function\n" >> $CASE_FUNCTION
    echo -e "{\n" >> $CASE_FUNCTION
    echo -e "#define VENDOR_DEVICE1 0x$2" >> $CASE_FUNCTION
    #$1 case dir
    #insert case iterm
    for file_name in `ls $1 | grep "\.h"`
    do
        #get case name (*.h strip ".h")
        #echo "***$file_name***"
        case_string=$(filter_string $file_name)
        #echo "***$case_string***"
        if [ $case_string ];then
            case_item=$(assemble_string $case_string)
            echo $case_item
            echo $case_item >> $CASE_FUNCTION
        fi
    done
    

    echo -e "\n\n\n\n" >> $CASE_FUNCTION
    echo -e "{0, NULL, NULL},\n" >> $CASE_FUNCTION
    echo -e "\n" >> $CASE_FUNCTION
    echo -e "};\n" >> $CASE_FUNCTION


}

#############test#############
#filter_string $1
#assemble_string $1
DIR_NAME=$1
VD_ID=$2
generate_case_file_h $DIR_NAME 
insert_case_iterm $DIR_NAME $VD_ID
