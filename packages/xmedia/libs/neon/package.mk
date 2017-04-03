################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="neon"
PKG_VERSION="0.30.1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.webdav.org/neon/"
PKG_URL="http://www.webdav.org/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain expat libressl"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/libs"
PKG_SHORTDESC="HTTP and WebDAV client library with a C interface"
PKG_LONGDESC="HTTP and WebDAV client library with a C interface."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
                           --enable-static \
                           --with-expat \
                           --with-ssl="openssl" \
                           --without-egd \
                           --without-libproxy"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  # pkgconf hack
  $SED "s:\(['=\" ]\)/usr:\\1$SYSROOT_PREFIX/usr:g" $SYSROOT_PREFIX/usr/bin/neon-config
  $SED "s:\([':\" ]\)-I\${includedir}:\\1-I$SYSROOT_PREFIX/usr/include:g" $SYSROOT_PREFIX/usr/lib/pkgconfig/neon.pc
}
