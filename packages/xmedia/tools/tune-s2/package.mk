################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="tune-s2"
PKG_VERSION="994a12b"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://bitbucket.org/updatelee/tune-s2"
PKG_URL="$ALEXELEC_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="tune-s2 is a small linux app I've wrote to be able to tune dvb devices"
PKG_LONGDESC="tune-s2 is a small linux app I've wrote to be able to tune dvb devices."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  CC=$CC CFLG=$LDFLAGS INCLUDE="-I $(kernel_path)" make
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp -P $ROOT/$PKG_BUILD/tune-s2 $INSTALL/usr/bin
}
