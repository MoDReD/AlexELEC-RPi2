################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="inputlirc"
PKG_VERSION="23"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL="http://saraev.ca/openelec/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="Zeroconf LIRC daemon using input event devices"
PKG_LONGDESC="This is a small LIRC-compatible daemon that reads from /dev/input/eventX devices and sends the received keycodes to connecting LIRC clients"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_build_target() {
  sed s%/usr/include/linux/input.h%$SYSROOT_PREFIX/usr/include/linux/input.h%g -i $ROOT/$PKG_BUILD/Makefile
  sed s%/usr/include/linux/input.h%linux/input.h%g -i $ROOT/$PKG_BUILD/inputlircd.c
}

make_target() {
  make PREFIX=/usr
}

makeinstall_target() {
  make DESTDIR=$INSTALL PREFIX=/usr install-sbin
  mkdir -p $INSTALL/usr/bin
    cp $PKG_DIR/bin/* $INSTALL/usr/bin
}

post_install() {
  enable_service inputlircd.service
}
