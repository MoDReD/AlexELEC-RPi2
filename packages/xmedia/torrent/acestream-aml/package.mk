################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="acestream-aml"
PKG_VERSION="3.1.19"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.acestream.com/"
PKG_URL="$ALEXELEC_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/torrent"
PKG_SHORTDESC="This is an innovative media platform of a new generation, which will take you to a new high-quality level of multimedia space on the Internet."
PKG_LONGDESC="This is an innovative media platform of a new generation, which will take you to a new high-quality level of multimedia space on the Internet."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : # nothing to make here
}

makeinstall_target() {
  DESTDIR=$INSTALL ./install

  mkdir -p $INSTALL/usr/bin
    cp $PKG_DIR/scripts/* $INSTALL/usr/bin
  mkdir -p $INSTALL/usr/config/acestream
    cp $PKG_DIR/config/* $INSTALL/usr/config/acestream
}

post_pkginstall_target() {
  for i in $INSTALL $INSTALL/usr; do
      rm -rf $i/include
      rm -rf $i/lib/pkgconfig
      rm -rf $i/share/man
      find $i -name "*.la" -exec rm -f "{}" ";" 2>/dev/null || true
      find $i -name "*.a" -exec rm -f "{}" ";" 2>/dev/null || true
      find $i -name "*.so*T" -exec rm -f "{}" ";" 2>/dev/null || true
      # patch backups nonsense
      find $i -name "*.orig" -exec rm -f "{}" ";" 2>/dev/null || true
  done
}
