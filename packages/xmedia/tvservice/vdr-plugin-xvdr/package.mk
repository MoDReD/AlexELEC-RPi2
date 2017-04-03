################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="vdr-plugin-xvdr"
PKG_VERSION="2d5e3f6"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/pipelka/vdr-plugin-xvdr"
PKG_URL="$ALEXELEC_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain vdr"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/tvservice"
PKG_SHORTDESC="TV"
PKG_LONGDESC="TV"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC"
  export CXXFLAGS="$CXXFLAGS -fPIC"
  export LDFLAGS="$LDFLAGS -fPIC"
}

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  make VDRDIR=$VDR_DIR \
       LIBDIR="." \
       LOCALEDIR="./locale"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/vdr
    cp libvdr-*.so.* $INSTALL/usr/lib/vdr
  mkdir -p $INSTALL/usr/config/vdr/plugins/xvdr
    cp $PKG_DIR/config/allowed_hosts.conf $INSTALL/usr/config/vdr/plugins/xvdr/
    cp xvdr/xvdr.conf $INSTALL/usr/config/vdr/plugins/xvdr/
}
