################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.ru
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.ru)
################################################################################

PKG_NAME="raspi2png"
PKG_VERSION="1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/AndrewFromMelbourne/raspi2png"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/pitools"
PKG_SHORTDESC="Utility to take a snapshot of the raspberry pi screen and save it as a PNG file"
PKG_LONGDESC="Utility to take a snapshot of the raspberry pi screen and save it as a PNG file."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : # nothing to do here
}

makeinstall_target() {
  : # nothing to do here
}

post_install() {
  mkdir -p $INSTALL/usr/bin
    cp -P $PKG_DIR/bin/* $INSTALL/usr/bin
  mkdir -p $INSTALL/usr/lib
    cp -P $PKG_DIR/lib/* $INSTALL/usr/lib
}
