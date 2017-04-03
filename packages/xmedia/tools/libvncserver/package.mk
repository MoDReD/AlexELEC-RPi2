################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="libvncserver"
PKG_VERSION="0.9.10"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://libvnc.github.io/"
PKG_URL="https://github.com/LibVNC/libvncserver/archive/LibVNCServer-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libjpeg-turbo libpng"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="LibVNCServer/LibVNCClient are cross-platform C libraries that allow you to easily implement VNC server or client functionality in your program."
PKG_LONGDESC="LibVNCServer/LibVNCClient are cross-platform C libraries that allow you to easily implement VNC server or client functionality in your program."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
                           --enable-static \
                           --with-sysroot=$SYSROOT_PREFIX \
                           --with-jpeg \
                           --with-png \
                           --without-sdl \
                           --without-gcrypt \
                           --without-client-gcrypt \
                           --without-gnutls"

unpack() {
  tar xf $SOURCES/libvncserver/LibVNCServer-$PKG_VERSION.tar.gz -C $ROOT/$BUILD
  mv $BUILD/libvncserver-LibVNCServer-$PKG_VERSION $BUILD/$PKG_NAME-$PKG_VERSION
}

post_makeinstall_target() {
  rm -fr $INSTALL/usr
}
