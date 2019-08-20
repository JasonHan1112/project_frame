#tips:
# $@: object file
# $^: all dependent files
# $<: the first dependent file

TOOLS_DIR = tools
SRC_DIR = src
PCIE_COMMON_DIR = pcie_common
LIB_DIR = lib
OUTPUT_DIR = out
PCIE_VALIDATION_CASE_DIR = ../validation_case/pcie_case
INCLUDE_DIR = -I$(PCIE_VALIDATION_CASE_DIR)/ -I$(PCIE_COMMON_DIR)/\
	-I$(LIB_DIR)/ -I$(PCIE_VALIDATION_CASE_DIR)/pl -I$(PCIE_VALIDATION_CASE_DIR)/tl\
	-I$(PCIE_VALIDATION_CASE_DIR)/dl -I$(PCIE_VALIDATION_CASE_DIR)/\
    -I$(PCIE_VALIDATION_CASE_DIR)/pcie

VPATH = lib:out:$(PCIE_COMMON_DIR): $(PCIE_VALIDATION_CASE_DIR):\
	$(PCIE_VALIDATION_CASE_DIR)/pl: $(PCIE_VALIDATION_CASE_DIR)/tl:\
	$(PCIE_VALIDATION_CASE_DIR)/dl: $(TOOLS_DIR): $(PCIE_VALIDATION_CASE_DIR)/pcie 

LIB_SMN_FILE = libsmn.c
WRITESMN_FILE = writesmn.c
READSMN_FILE = readsmn.c



CC = @gcc
LD = ld

FLAGS = -D LITTLEENDIAN_CPU -D ENV_OS=1 $(INCLUDE_DIR) -g -w
#set DEBUG macro
#DEBUG = 1
############################################################################
ifeq ($(DEBUG), 1)
FLAGS += -D DEBUG
endif
############################################################################

#set DEV_MEM /dev/mem or /dev/mem_map
ifeq ($(MEM_MAP), 1)
FLAGS += -D MEM_MAP
else
endif


all: add_include_h_files main
	@echo "generate main.out in out/ complete!"


.PHONY: all clean

.DEFAULT: 
	@make all
	@echo "********default make complete********"






#auto generate case_file.h
#need && every line in a sub shell, enviroment var will reset
############################################################################
ifdef VD_ID
    VENDOR_DEVICE_ID=$(VD_ID)
else
    VENDOR_DEVICE_ID=15728086
endif

add_include_h_files:
ifdef H_FILES
	@cd ./$(PCIE_VALIDATION_CASE_DIR) && ./gen_case_file.sh $(H_FILES) $(VENDOR_DEVICE_ID)	
	@echo "******auto prepare case_file.h and case_function.h complete!!!******"
else
	@echo "******need manually prepare case_file.h and case_function.h******"
    
endif
############################################################################




#pcie_common compile
############################################################################
PCIE_COMMON_SRCS = $(wildcard $(PCIE_COMMON_DIR)/*.c)#get all .c files
PCIE_COMMON_OBJS=${patsubst %.c, %.o, $(PCIE_COMMON_SRCS)}#get all .o objs

$(PCIE_COMMON_DIR)/%.o: $(PCIE_COMMON_DIR)/%.c#generate all .o objs
	@echo "Building $^ ..."
	$(CC) $(FLAGS) -c $^ -o $(OUTPUT_DIR)/$(notdir $@)

pcie_common: $(PCIE_COMMON_OBJS)
############################################################################


#lib compile
############################################################################

#only compile to .o
libsmn: $(LIB_SMN_FILE)
	@echo "compiling libsmn..."
	$(CC) $(FLAGS) -c $^ -o $(OUTPUT_DIR)/$@.o

#generate writesmn tool
writesmn: $(WRITESMN_FILE) libsmn
	@echo "compiling tool writesmn..."
	$(CC) $(FLAGS) -c $< -o $(OUTPUT_DIR)/$@.o #compiling writesmn.o
	$(CC) $(OUTPUT_DIR)/$@.o $(OUTPUT_DIR)/libsmn.o -o $(OUTPUT_DIR)/$@ #generate writesmn

#generate readsmn tool
readsmn: $(READSMN_FILE) libsmn
	@echo "compiling tool readsmn..."
	$(CC) $(FLAGS) -c $< -o $(OUTPUT_DIR)/$@.o #compiling readsmn.o
	$(CC) $(OUTPUT_DIR)/$@.o $(OUTPUT_DIR)/libsmn.o -o $(OUTPUT_DIR)/$@ #generate readsmn

#only generate writesmn and readsmn
tools: readsmn writesmn
	@echo "generate writesmn and readsmn in $(OUTPUT_DIR)/"
	


#compile LIB_DIR
############################################################################
LIB_SRCS = $(wildcard $(LIB_DIR)/*.c)#get all .c files
LIB_OBJS=${patsubst %.c, %.o, $(LIB_SRCS)}#get all .o objs

$(LIB_DIR)/%.o: $(LIB_DIR)/%.c#generate all .o objs
	@echo "Building $^ ..."
	$(CC) $(FLAGS) -c $^ -o $(OUTPUT_DIR)/$(notdir $@)

lib: $(LIB_OBJS)
	@echo "compiling lib/"


############################################################################


#pcie dir validation compile
############################################################################
PCIE_VALIDATION_PCIE_CASE_SRC = $(wildcard $(PCIE_VALIDATION_CASE_DIR)/pcie/*.c)
PCIE_VALIDATION_PCIE_CASE_OBJ = ${patsubst %.c, %.o, $(PCIE_VALIDATION_PCIE_CASE_SRC)}

$(PCIE_VALIDATION_CASE_DIR)/pcie/%.o: $(PCIE_VALIDATION_CASE_DIR)/pcie/%.c#generate all .o objs
	@echo "Building $^..."
	$(CC) $(FLAGS) -c $^ -o $(OUTPUT_DIR)/$(notdir $@)

pcie_validation_pcie: $(PCIE_VALIDATION_PCIE_CASE_OBJ)
############################################################################




#pl dir validation compile
############################################################################
PCIE_VALIDATION_PL_CASE_SRC = $(wildcard $(PCIE_VALIDATION_CASE_DIR)/pl/*.c)
PCIE_VALIDATION_PL_CASE_OBJ = ${patsubst %.c, %.o, $(PCIE_VALIDATION_PL_CASE_SRC)}

$(PCIE_VALIDATION_CASE_DIR)/pl/%.o: $(PCIE_VALIDATION_CASE_DIR)/pl/%.c#generate all .o objs
	@echo "Building $^..."
	$(CC) $(FLAGS) -c $^ -o $(OUTPUT_DIR)/$(notdir $@)

pcie_validation_pl: $(PCIE_VALIDATION_PL_CASE_OBJ)
############################################################################



#dl dir validation compile
############################################################################
PCIE_VALIDATION_DL_CASE_SRC = $(wildcard $(PCIE_VALIDATION_CASE_DIR)/dl/*.c)
PCIE_VALIDATION_DL_CASE_OBJ = ${patsubst %.c, %.o, $(PCIE_VALIDATION_DL_CASE_SRC)}

$(PCIE_VALIDATION_CASE_DIR)/dl/%.o: $(PCIE_VALIDATION_CASE_DIR)/dl/%.c#generate all .o objs
	@echo "Building $^..."
	$(CC) $(FLAGS) -c $^ -o $(OUTPUT_DIR)/$(notdir $@)

pcie_validation_dl: $(PCIE_VALIDATION_DL_CASE_OBJ)
############################################################################


#tl dir validation compile
############################################################################
PCIE_VALIDATION_TL_CASE_SRC = $(wildcard $(PCIE_VALIDATION_CASE_DIR)/tl/*.c)
PCIE_VALIDATION_TL_CASE_OBJ = ${patsubst %.c, %.o, $(PCIE_VALIDATION_TL_CASE_SRC)}

$(PCIE_VALIDATION_CASE_DIR)/tl/%.o: $(PCIE_VALIDATION_CASE_DIR)/tl/%.c#generate all .o objs
	@echo "Building $^..."
	$(CC) $(FLAGS) -c $^ -o $(OUTPUT_DIR)/$(notdir $@)

pcie_validation_tl: $(PCIE_VALIDATION_TL_CASE_OBJ)
############################################################################

PCIE_VALIDATION_CASE = pcie_validation_tl pcie_validation_dl pcie_validation_pl pcie_validation_pcie

#src compile
############################################################################
SRC_SRCS = $(wildcard $(SRC_DIR)/*.c)
SRC_OBJS = ${patsubst %.c, %.o, $(SRC_SRCS)}

$(SRC_DIR)/%.o: $(SRC_DIR)/%.c
	@echo "Building $^..."
	$(CC) $(FLAGS) -c $^ -o $(OUTPUT_DIR)/$(notdir $@)
src: $(SRC_OBJS)
############################################################################

main: src pcie_common lib $(PCIE_VALIDATION_CASE) 
	@echo "link main.out..."
	$(CC) $(OUTPUT_DIR)/*.o -o $(OUTPUT_DIR)/$@.out #generate main.out
	
	


clean:
	@echo "clean..."
	@rm $(OUTPUT_DIR)/* -rf
