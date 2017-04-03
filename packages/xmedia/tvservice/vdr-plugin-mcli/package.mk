################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.ru
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.ru)
################################################################################

PKG_NAME="vdr-plugin-mcli"
PKG_VERSION="907338b"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://projects.vdr-developer.org/projects/plg-mcli"
PKG_URL="$ALEXELEC_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain vdr"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/tvservice"
PKG_SHORTDESC="VDR access DVB-streams produced by the NetCeiver-hardware"
PKG_LONGDESC="VDR access DVB-streams produced by the NetCeiver-hardware."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC"
  export CXXFLAGS="$CXXFLAGS -fPIC"
  export LDFLAGS="$LDFLAGS -fPIC"
}

make_target() {
  (cd mcast/client; make)
  VDR_DIR=$(get_build_dir vdr)
  make all \
      VDRDIR="$VDR_DIR" \
      LOCALEDIR="./locale" \
      XMLCONF="$SYSROOT_PREFIX/usr/bin/xml2-config"
}

makeinstall_target() {
  VDR_DIR=$(get_build_dir vdr)
  make VDRDIR="$VDR_DIR" \
       LOCALEDIR="./locale" \
	   DESTDIR=$INSTALL \
       XMLCONF="$SYSROOT_PREFIX/usr/bin/xml2-config" \
       install
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

  mkdir -p $INSTALL/usr/share
    cp -a locale $INSTALL/usr/share
}
