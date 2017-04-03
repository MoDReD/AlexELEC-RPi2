################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="minidlna"
PKG_VERSION="4ec6cd0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://minidlna.sourceforge.net/"
PKG_URL="$ALEXELEC_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain sqlite libexif libid3tag flac"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="MiniDLNA is server software with the aim of being fully compliant with DLNA/UPnP-AV clients"
PKG_LONGDESC="MiniDLNA is server software with the aim of being fully compliant with DLNA/UPnP-AV clients."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--prefix=/usr \
			               --sbindir=/usr/bin \
                           --with-os-name="Alex@ELEC" \
			               --with-os-version="$ALEXELEC_VERSION" \
			               --with-os-url="www.alexelec.in.ua" \
			               --with-log-path=/var/log \
			               --with-db-path=/storage/.cache/minidlna"

pre_configure_target() {
  cd $ROOT/$PKG_BUILD
    cp -rf * .$TARGET_NAME
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/config/minidlna
    cp -PR $PKG_DIR/config/*.conf $INSTALL/usr/config/minidlna
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

post_install() {
  enable_service minidlna.service
}
