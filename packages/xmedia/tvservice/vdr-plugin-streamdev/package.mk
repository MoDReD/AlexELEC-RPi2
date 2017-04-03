################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="vdr-plugin-streamdev"
PKG_VERSION="d66c635"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://projects.vdr-developer.org/projects/show/plg-streamdev"
PKG_URL="$ALEXELEC_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain vdr libressl"
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
       LOCDIR="./locale"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/vdr
    cp client/libvdr-streamdev*.so.* $INSTALL/usr/lib/vdr
    cp server/libvdr-streamdev*.so.* $INSTALL/usr/lib/vdr

  mkdir -p $INSTALL/usr/config/vdr/plugins/streamdev-server
    cp streamdev-server/* $INSTALL/usr/config/vdr/plugins/streamdev-server
    echo '0.0.0.0/0' >> $INSTALL/usr/config/vdr/plugins/streamdev-server/streamdevhosts.conf

  mkdir -p $INSTALL/usr/share
    cp -a server/locale $INSTALL/usr/share
    cp -a client/locale $INSTALL/usr/share
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

  find $INSTALL -type d -exec rmdir -p "{}" ";" 2>/dev/null || true

  $STRIP `find $INSTALL -name "*.so" 2>/dev/null` 2>/dev/null || :
  $STRIP `find $INSTALL -name "*.so.[0-9]*" 2>/dev/null` 2>/dev/null || :
}
