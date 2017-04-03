################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.ru
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.ru)
################################################################################

PKG_NAME="boblightd"
PKG_VERSION="479"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://code.google.com/p/boblight"
PKG_URL="$ALEXELEC_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain libusb"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="boblightd: an ambilight controller."
PKG_LONGDESC="Boblight's main purpose is to create light effects from an external input, such as a video stream.\n\nSee this thread on the Openelec forums for howto and demonstration: http://bit.ly/oe-boblight"
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--without-opengl \
      --without-x11 \
      --without-portaudio \
      --sysconfdir=/storage/.config/boblight \
      --enable-shared \
      --disable-static"

post_install() {
  mkdir -p  $INSTALL/usr/config/boblight
    cp -R $PKG_DIR/config/boblight.conf $INSTALL/usr/config/boblight

  enable_service boblightd.service
}
