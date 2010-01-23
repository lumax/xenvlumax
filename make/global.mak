rm=/bin/rm -f

CXX=${CROSS_COMPILE}gcc
LINKER=${CROSS_COMPILE}gcc
LOADER=${CROSS_COMPILE}ldd
FILE=file

AR=${CROSS_COMPILE}ar
AS=${CROSS_COMPILE}as
#CC=${CROSS_COMPILE}gcc
#CXX=${CROSS_COMPILE}g++
LD=${CROSS_COMPILE}ld
NM=${CROSS_COMPILE}nm
OBJCOPY=${CROSS_COMPILE}objcopy
OBJDUMP=${CROSS_COMPILE}objdump
RANLIB=${CROSS_COMPILE}ranlib
READELF=${CROSS_COMPILE}readelf
STRIP=${CROSS_COMPILE}strip

#GREAT_CODE=echo -----


DEFS+=  
EXE=$(PROJECT_NAME)$(EXE_ANHANG)
INCLUDES+=  -I.
LIBS+=

DEFINES+= $(INCLUDES) $(DEFS) 
CFLAGS+= $(DEFINES)
LDFLAGS+= 


OBJS+=
#$(PROJECT_NAME).o 

.c.o:
	$(rm) $@
	$(CXX) $(CFLAGS) -c $*.c
#	@$(GREAT_CODE) -file-$*.c

all: clean $(EXE)

lib: all devpub

$(EXE) : $(OBJS)
	$(LINKER) $(LDFLAGS) -o $(EXE) $(OBJS) $(LIBS)

clean:
	$(rm) $(OBJS) $(EXE) core.* core *~ gmon.out *.gcov *.gcda *.gcno

libs_used:
	$(LOADER) $(EXE)

file_type:
	$(FILE) $(EXE)

devpub:
	ln -sf $(PROJECT_NAME).so.$(VERSION) $(PROJECT_NAME).so
	mv -f $(PROJECT_NAME).so.$(VERSION) $(LIB_DIR)/$(PROJECT_NAME).so.$(VERSION)
	mv -f $(PROJECT_NAME).so $(LIB_DIR)/$(PROJECT_NAME).so
	rm -fR $(INCLUDE_DIR)/$(PROJECT_NAME)
	mkdir -p $(INCLUDE_DIR)/$(PROJECT_NAME)
	cp *.h $(INCLUDE_DIR)/$(PROJECT_NAME)/