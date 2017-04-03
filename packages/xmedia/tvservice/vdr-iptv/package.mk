################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="vdr-iptv"
PKG_VERSION="2.2.1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.saunalahti.fi/~rahrenbe/vdr/iptv/"
PKG_URL="http://www.saunalahti.fi/~rahrenbe/vdr/iptv/files/$PKG_NAME-$PKG_VERSION.tgz"
PKG_SOURCE_DIR="iptv-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain vdr curl"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="vdr-iptv: an IPTV plugin for the Video Disk Recorder (VDR)"
PKG_LONGDESC="vdr-iptv is an IPTV plugin for the Video Disk Recorder (VDR)"
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
       DVBCHANPATCH=1
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/config
    mv -f $INSTALL/storage/.config/vdr $INSTALL/usr/config/vdr
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

  rm -rf $INSTALL/storage
}
