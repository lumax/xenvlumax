#!/bin/bash
CURRENT_DIR=$PWD
WORK_DIR=`cat work-dir`
cd $WORK_DIR

export LUMAX_EXT="c"
export LUMAX_COMPILER="gcc"
export MAKE_DIR="$WORK_DIR/make"
export ARCH=arm
export CROSS_COMPILE=bfin-linux-uclibc-
#export ELDK_ROOT=`cat eldk-root`
export ELDK_FS=`cat bfin-fs`
export BFIN_STAGING="/opt/blackfin-linux-dist/staging"
export OS="LINUX"
export STAGE="$WORK_DIR/stage/bfin"
export SYSROOT=$ELDK_FS
export PKG_CONFIG=$MAKE_DIR/${CROSS_COMPILE}pkg-config
export PKG_CONFIG_PATH=$ELDK_FS/usr/local/lib 

export LIB_DIR="$STAGE/usr/lib"
export INCLUDE_DIR="$STAGE/usr/local/include:$STAGE/usr/include"
export LD_LIBRARY_PATH="$STAGE/usr/local/lib:$ROOT_FS/usr/local/lib"

declare tmp=$LIB_DIR
if [ ! -d $tmp ]; then
mkdir -p $tmp; fi

declare tmp=$INCLUDE_DIR
if [ ! -d $tmp ]; then
mkdir -p $tmp; fi


export CFLAGS='-isystem '$BFIN_STAGING'/usr/include -isystem '$BFIN_STAGING'/usr/include/freetype2 '
export LDFLAGS='-L'$LIB_DIR' -L'$ELDK_FS'/lib -L'$ELDK_FS'/usr/lib -L'$ELDK_FS'/usr/local/lib -Wl,-rpath-link -Wl,'$ELDK_FS'/lib -L'$ELDK_FS'/lib -Wl,-rpath-link -Wl,'$ELDK_FS'/usr/lib -L'$ELDK_FS'/usr/lib -Wl,-rpath-link -Wl,'$LIB_DIR' -Wl,-rpath-link -Wl,'$ELDK_FS'/usr/lib -Wl,-rpath-link -Wl,'$ELDK_FS'/lib -L'$ELDK_FS'/lib -Wl,-rpath-link -Wl,'$ELDK_FS'/usr/lib -L'$ELDK_FS'/usr/lib' 

export CPPFLAGS=$CFLAGS 
#CXXFLAGS=$CFLAGS -

cd $CURRENT_DIR
