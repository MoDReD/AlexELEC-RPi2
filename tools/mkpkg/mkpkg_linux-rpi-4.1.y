#!/bin/sh
################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

echo "getting sources..."
  if [ ! -d linux-rpi.git ]; then
    git clone git://github.com/raspberrypi/linux.git -b rpi-4.1.y linux-rpi.git
  fi

  cd linux-rpi.git
    git pull
    #GIT_REV=`git log -n1 --format=%h`
    GIT_REV="4.1.15"
  cd ..

echo "copying sources..."
  rm -rf linux-$GIT_REV
  cp -R linux-rpi.git linux-$GIT_REV

echo "cleaning sources..."
  rm -rf linux-$GIT_REV/.git

echo "packing sources..."
  tar cvJf linux-$GIT_REV.tar.xz linux-$GIT_REV

echo "remove temporary sourcedir..."
  rm -rf linux-$GIT_REV
  rm -rf linux-rpi.git
