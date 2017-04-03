################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.ru
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.ru)
################################################################################

PKG_NAME="hid-driver"
PKG_VERSION="4e60834"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/Claudio-Sjo/HID_linux_xbmc_driver/"
PKG_URL="$ALEXELEC_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="This is a generic hid driver for use with XBMC if your computer came with a hid remote or you bought one"
PKG_LONGDESC="This is a generic hid driver for use with XBMC if your computer came with a hid remote or you bought one."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp -P $ROOT/$PKG_BUILD/hid_mapper $INSTALL/usr/bin
    cp $PKG_DIR/bin/* $INSTALL/usr/bin

  mkdir -p $INSTALL/usr/config/hid_map
    cp $PKG_DIR/config/* $INSTALL/usr/config/hid_map
}
