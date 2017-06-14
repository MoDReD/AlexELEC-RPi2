################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="vdr-epgsearch"
PKG_VERSION="0b09f90"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://projects.vdr-developer.org/git/vdr-plugin-epgsearch.git/"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain vdr"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/tvservice"
PKG_SHORTDESC="VDR -- epgsearch plugin"
PKG_LONGDESC="vdr-epgsearch is a plugin for VDR, the Video Disk Recorder."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_LOCALE_INSTALL="yes"

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC -L$SYSROOT_PREFIX/usr/lib -L$SYSROOT_PREFIX/lib"
  export CXXFLAGS="$CXXFLAGS -fPIC -L$SYSROOT_PREFIX/usr/lib -L$SYSROOT_PREFIX/lib"
  export LDFLAGS="$LDFLAGS -fPIC -L$SYSROOT_PREFIX/usr/lib -L$SYSROOT_PREFIX/lib"
}

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  make VDRDIR=$VDR_DIR
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/config/vdr/plugins/epgsearch
    cp -PR $PKG_DIR/config/* $INSTALL/usr/config/vdr/plugins/epgsearch
  rm -rf $INSTALL/storage
}
