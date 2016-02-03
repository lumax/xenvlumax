#!/bin/bash
PATH=$PATH:/opt/eldk-4.2/usr/bin:/opt/eldk-4.2/bin
export PATH
CURRENT_DIR=$PWD
WORK_DIR=`cat work-dir`
cd $WORK_DIR

export LUMAX_EXT="c"
export LUMAX_COMPILER="gcc"
export MAKE_DIR="$WORK_DIR/make"
export ARCH=arm
export CROSS_COMPILE=arm-linux-
export ELDK_ROOT=`cat eldk-root`
export ELDK_FS=`cat eldk-fs`
export OS="LINUX"
export STAGE="$WORK_DIR/stage/arm"
export SYSROOT=$ELDK_FS
export PKG_CONFIG=$MAKE_DIR/${CROSS_COMPILE}pkg-config
export PKG_CONFIG_PATH=$ELDK_FS/usr/local/lib 

export LIB_DIR="$STAGE/usr/local/lib"
export INCLUDE_DIR="$STAGE/usr/local/include"
export LD_LIBRARY_PATH="$STAGE/usr/local/lib:$ROOT_FS/usr/local/lib"

declare tmp=$LIB_DIR
if [ ! -d $tmp ]; then
mkdir -p $tmp; fi

declare tmp=$INCLUDE_DIR
if [ ! -d $tmp ]; then
mkdir -p $tmp; fi


export CFLAGS='-isystem '$ELDK_FS'/usr/local/include -isystem '$ELDK_FS'/usr/include/freetype2 -isystem '$ELDK_FS'/usr/include'
export LDFLAGS='-L'$LIB_DIR' -L'$ELDK_FS'/lib -L'$ELDK_FS'/usr/lib -L'$ELDK_FS'/usr/local/lib -Wl,-rpath-link -Wl,'$ELDK_FS'/usr/local/lib -L'$ELDK_FS'/usr/local/lib  -Wl,-rpath-link -Wl,'$LIB_DIR 

CPPFLAGS=$CFLAGS 
CXXFLAGS=$CFLAGS 

cd $CURRENT_DIR
