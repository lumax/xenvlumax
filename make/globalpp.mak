rm=/bin/rm -f

CXX=${CROSS_COMPILE}g++
LINKER=${CROSS_COMPILE}g++
LOADER=${CROSS_COMPILE}ldd
FILE=file
GREAT_CODE=echo -----


DEFS+=  
EXE= $(PROJECT_NAME)
INCLUDES+=  -I.
LIBS+=

DEFINES+= $(INCLUDES) $(DEFS) 
CPPFLAGS+= $(DEFINES) -Wall
LDFLAGS+= 


OBJS+=
#$(PROJECT_NAME).o

.c.cc.o:
	$(rm) $@
	$(CXX) $(CPPFLAGS) -c $*.cc
	@$(GREAT_CODE) -file-$*.cc

all: $(EXE)

$(EXE) : $(OBJS)
	$(LINKER) $(LDFLAGS) -o $(EXE) $(OBJS) $(LIBS)

clean:
	$(rm) $(OBJS) $(EXE) core.* core *~ gmon.out *.gcov *.gcda *.gcno

libs_used:
	$(LOADER) $(EXE)

file_type:
	$(FILE) $(EXE)

