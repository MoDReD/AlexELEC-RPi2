################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.ru
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.ru)
################################################################################

PKG_NAME="scan-m3u"
PKG_VERSION="1.1"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.alexelec.ru"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="scan-m3u: scan IPTV channels for VDR"
PKG_LONGDESC="scan-m3u: scan IPTV channels for VDR."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC"
  export CXXFLAGS="$CXXFLAGS -fPIC"
  export LDFLAGS="$LDFLAGS -fPIC"
}

make_target() {
  cp -aP $PKG_DIR/source/* ./
  CC=$CC CFLAGS=$CFLAGS ./shc -v -r -B -f m3u_info.sh
  CC=$CC CFLAGS=$CFLAGS ./shc -v -r -B -f scan-m3u.sh
  CC=$CC CFLAGS=$CFLAGS ./shc -v -r -B -f live-ttv.sh
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp m3u_info.sh.x $INSTALL/usr/bin/m3u_info
    cp scan-m3u.sh.x $INSTALL/usr/bin/scan-m3u
    cp live-ttv.sh.x $INSTALL/usr/bin/live-ttv
  mkdir -p $INSTALL/usr/config/acestream
    cp $PKG_DIR/config/* $INSTALL/usr/config/acestream
}
