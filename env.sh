#!/bin/bash
CURRENT_DIR=$PWD
WORK_DIR="/home/lumax/xw"
cd $WORK_DIR

export MAKE_DIR="$WORK_DIR/make"
export ARCH=
export CROSS_COMPILE=
export ELDK_ROOT=
export ELDK_FS=
export OS="LINUX"
export STAGE="$WORK_DIR/stage/x86"
export SYSROOT=$ELDK_FS
export PKG_CONFIG=pkg-config
export PKG_CONFIG_PATH=

export LIB_DIR="$STAGE/usr/local/lib"
export INCLUDE_DIR="$STAGE/usr/local/include"
export LD_LIBRARY_PATH="$STAGE/usr/local/lib:$ROOT_FS/usr/local/lib"

declare tmp=$LIB_DIR
if [ ! -d $tmp ]; then
mkdir -p $tmp; fi

declare tmp=$INCLUDE_DIR
if [ ! -d $tmp ]; then
mkdir -p $tmp; fi


export CFLAGS=
export LDFLAGS='-L'$LIB_DIR


CPPFLAGS=$CFLAGS 
CXXFLAGS=$CFLAGS

cd $CURRENT_DIR



