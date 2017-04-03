################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.ru
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.ru)
################################################################################

PKG_NAME="wicard"
PKG_VERSION="1.19"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://www.alexelec.ru"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/camd"
PKG_SHORTDESC="wicard"
PKG_LONGDESC="wicard."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : # nothing to do here
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/config/wicard
    cp $PKG_DIR/config/* $INSTALL/usr/config/wicard
  mkdir -p $INSTALL/usr/bin
    cp $PKG_DIR/bin/wicard.start $INSTALL/usr/bin/
    cp $PKG_DIR/bin/wicard-switch.start $INSTALL/usr/bin/
  # Wicard bin must be writeable
  cp $PKG_DIR/bin/wicardd $INSTALL/usr/config/wicard/
    ln -sf /storage/.config/wicard/wicardd $INSTALL/usr/bin/wicardd
}

post_install() {
  enable_service wicard-switch.service
  enable_service wicard.service
}
