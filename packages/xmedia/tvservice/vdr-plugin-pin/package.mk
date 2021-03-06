################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="vdr-plugin-pin"
PKG_VERSION="53afeeb"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://projects.vdr-developer.org/git/vdr-plugin-pin.git/tree/README"
PKG_URL="$ALEXELEC_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain vdr"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/tvservice"
PKG_SHORTDESC="VDR PIN"
PKG_LONGDESC="VDR PIN"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_LOCALE_INSTALL="yes"

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC"
  export CXXFLAGS="$CXXFLAGS -fPIC"
  export LDFLAGS="$LDFLAGS -fPIC"
}

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  make all \
      VDRDIR="$VDR_DIR" \
      VDRSRC="$VDR_DIR" \
      STRIP=$STRIP
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp -p scripts/* $INSTALL/usr/bin
    cp -p fskcheck $INSTALL/usr/bin
}
