################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="vdr-plugin-vnsiserver"
PKG_VERSION="615a077"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/FernetMenta/vdr-plugin-vnsiserver"
PKG_GIT_URL="https://github.com/FernetMenta/vdr-plugin-vnsiserver.git"
PKG_DEPENDS_TARGET="toolchain vdr"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/tvservice"
PKG_SHORTDESC="TV"
PKG_LONGDESC="TV"
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
  make VDRDIR=$VDR_DIR
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/config/vdr/plugins/vnsiserver
    cp $PKG_DIR/config/allowed_hosts.conf $INSTALL/usr/config/vdr/plugins/vnsiserver
}
