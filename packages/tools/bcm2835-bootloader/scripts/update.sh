#!/bin/sh

################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

[ -z "$BOOT_ROOT" ] && BOOT_ROOT="/flash"
[ -z "$SYSTEM_ROOT" ] && SYSTEM_ROOT=""

# mount $BOOT_ROOT r/w
  mount -o remount,rw $BOOT_ROOT

# update bootloader files
  cp -p $SYSTEM_ROOT/usr/share/bootloader/LICENCE* $BOOT_ROOT
  cp -p $SYSTEM_ROOT/usr/share/bootloader/bootcode.bin $BOOT_ROOT
  cp -p $SYSTEM_ROOT/usr/share/bootloader/fixup.dat $BOOT_ROOT
  cp -p $SYSTEM_ROOT/usr/share/bootloader/start.elf $BOOT_ROOT

  cp -p $SYSTEM_ROOT/usr/share/bootloader/*.dtb $BOOT_ROOT
  cp -pR $SYSTEM_ROOT/usr/share/bootloader/overlays $BOOT_ROOT

# cleanup not more needed files
  rm -rf $BOOT_ROOT/loader.bin
  rm -rf $BOOT_ROOT/fixup_x.dat
  rm -rf $BOOT_ROOT/start_x.elf

# some config.txt magic
  if [ ! -f $BOOT_ROOT/config.txt ]; then
    cp -p $SYSTEM_ROOT/usr/share/bootloader/config.txt $BOOT_ROOT
  elif [ -z "`grep "^[ ]*gpu_mem.*" $BOOT_ROOT/config.txt`" ]; then
    mv $BOOT_ROOT/config.txt $BOOT_ROOT/config.txt.bk
    cat $SYSTEM_ROOT/usr/share/bootloader/config.txt \
        $BOOT_ROOT/config.txt.bk > $BOOT_ROOT/config.txt
  fi

# mount $BOOT_ROOT r/o
  sync
  mount -o remount,ro $BOOT_ROOT
