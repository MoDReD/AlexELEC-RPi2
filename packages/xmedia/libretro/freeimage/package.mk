################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="freeimage"
PKG_VERSION="3170"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="http://freeimage.sourceforge.net/"
PKG_URL="http://downloads.sourceforge.net/freeimage/FreeImage$PKG_VERSION.zip"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/libretro"
PKG_SHORTDESC="FreeImage library"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

unpack() {
  unzip $SOURCES/$PKG_NAME/FreeImage$PKG_VERSION.zip -d $BUILD
  mv $BUILD/FreeImage $BUILD/$PKG_NAME-$PKG_VERSION
}

make_target() {
  DESTDIR=$SYSROOT_PREFIX make
}
