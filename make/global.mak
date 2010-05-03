rm=/bin/rm -f


CXX=${CROSS_COMPILE}${LUMAX_COMPILER}
LINKER=${CROSS_COMPILE}${LUMAX_COMPILER}
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

.$(LUMAX_EXT).o:
	$(rm) $@
	$(CXX) $(CFLAGS) -c $*.$(LUMAX_EXT)

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
	cp -f $(PROJECT_NAME).so.$(VERSION) $(LIB_DIR)/$(PROJECT_NAME).so.$(VERSION)
	mv -f $(PROJECT_NAME).so $(LIB_DIR)/$(PROJECT_NAME).so
	rm -fR $(INCLUDE_DIR)/$(PROJECT_NAME)
	mkdir -p $(INCLUDE_DIR)/$(PROJECT_NAME)
	cp *.h $(INCLUDE_DIR)/$(PROJECT_NAME)/

eldkpub: devpub
	ln -sf $(PROJECT_NAME).so.$(VERSION) $(PROJECT_NAME).so
	cp -f $(PROJECT_NAME).so.$(VERSION) $(ELDK_FS)/usr/local/lib/$(PROJECT_NAME).so.$(VERSION)
	mv -f $(PROJECT_NAME).so $(ELDK_FS)/usr/local/lib/$(PROJECT_NAME).so
	rm -fR $(ELDK_FS)/usr/local/include/$(PROJECT_NAME)
	mkdir -p $(ELDK_FS)/usr/local/include/$(PROJECT_NAME)
	cp *.h $(ELDK_FS)/usr/local/include/$(PROJECT_NAME)

libpackage: devpub
#Packverzeichnis erzeugen
	rm -fR $(STAGE)/pack/$(PROJECT_NAME)
	mkdir -p $(STAGE)/pack/$(PROJECT_NAME)/usr/local/lib
#lib kopieren
	ln -sf $(PROJECT_NAME).so.$(VERSION) $(PROJECT_NAME).so 
	cp -f $(PROJECT_NAME).so.$(VERSION) $(STAGE)/pack/$(PROJECT_NAME)/usr/local/lib/$(PROJECT_NAME).so.$(VERSION)
	mv -f $(PROJECT_NAME).so $(STAGE)/pack/$(PROJECT_NAME)/usr/local/lib/$(PROJECT_NAME).so
#header Dateien kopieren
	rm -fR $(STAGE)/pack/$(PROJECT_NAME)/usr/local/include/$(PROJECT_NAME)
	mkdir -p $(STAGE)/pack/$(PROJECT_NAME)/usr/local/include/$(PROJECT_NAME)
	cp *.h $(STAGE)/pack/$(PROJECT_NAME)/usr/local/include/$(PROJECT_NAME)
#package erzeugen
	tar czf $(PROJECT_NAME).$(VERSION).tar.gz -C $(STAGE)/pack/$(PROJECT_NAME) usr