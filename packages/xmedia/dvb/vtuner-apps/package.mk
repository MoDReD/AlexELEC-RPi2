################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.ru
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.ru)
################################################################################

PKG_NAME="vtuner-apps"
PKG_VERSION="116"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://code.google.com/p/vtuner/"
PKG_URL="$ALEXELEC_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="vtuner-driver"
PKG_BUILD_DEPENDS_TARGET="toolchain linux"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/dvb"
PKG_SHORTDESC="vtuner: access DVB devices over the network."
PKG_LONGDESC="vtuner: access DVB devices over the network."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  cd $ROOT/$PKG_BUILD
  export CFLAGS="$CFLAGS -fpic -DHAVE_DVB_API_VERSION=5"
  export LDFLAGS="$LDFLAGS -lpthread -lrt"
  CC=$CC CXX=$CXX STRIP=$STRIP  make V=1 -C ./build/arm/ all
}

makeinstall_target() {
  : # nothing to do here
}

post_install() {
  mkdir -p $INSTALL/usr/bin
    cp $PKG_BUILD/dist/arm/vtunerc.arm $INSTALL/usr/bin/vtunerc
	cp $PKG_BUILD/dist/arm/vtunerd.arm $INSTALL/usr/bin/vtunerd
    cp $PKG_DIR/bin/* $INSTALL/usr/bin

  enable_service vtunerc.service
}
