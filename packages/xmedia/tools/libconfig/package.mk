################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="libconfig"
PKG_VERSION="1.5"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://hyperrealm.com/libconfig/libconfig.html"
PKG_URL="https://github.com/hyperrealm/libconfig/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="lib"
PKG_SHORTDESC="C/C++ Configuration File Library"
PKG_LONGDESC="C/C++ Configuration File Library"
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-examples \
                           --with-sysroot=$SYSROOT_PREFIX"

unpack() {
  tar xf $SOURCES/$PKG_NAME/v$PKG_VERSION.tar.gz -C $ROOT/$BUILD
}
