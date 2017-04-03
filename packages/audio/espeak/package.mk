#!/bin/bash
################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="espeak"
PKG_VERSION="1.48.04-source"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://espeak.sourceforge.net/"
PKG_URL="http://sourceforge.net/projects/espeak/files/espeak/espeak-1.48/$PKG_NAME-$PKG_VERSION.zip"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="audio"
PKG_SHORTDESC="Text to Speech engine for English, with support for other languages"
PKG_LONGDESC="Text to Speech engine for English, with support for other languages"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_make_target() {
  cp src/portaudio19.h src/portaudio.h
}

make_target() {
  make -C src \
       CXXFLAGS="$CXXFLAGS" \
       LDFLAGS="$LDFLAGS" \
       AUDIO=""
}

makeinstall_target() {
  make -C src \
       CXXFLAGS="$CXXFLAGS" \
       LDFLAGS="$LDFLAGS" \
       AUDIO="" \
       DESTDIR=$INSTALL install
}
