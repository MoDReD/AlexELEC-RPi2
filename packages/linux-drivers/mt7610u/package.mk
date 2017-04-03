################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="mt7610u"
PKG_VERSION="34a7865"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
# mediatek: PKG_SITE="http://www.mediatek.com/en/downloads/mt7610u-usb/"
PKG_SITE="https://github.com/sohaib17/mt7610u"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_PRIORITY="optional"
PKG_SECTION="driver"
PKG_SHORTDESC="Mediatek mt7610u Linux driver"
PKG_LONGDESC="Mediatek mt7610u Linux driver"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  sed -i '198s|.*LINUX_SRC.*|LINUX_SRC = '$(kernel_path)'|' Makefile
  sed -i '199s|.*LINUX_SRC_MODULE.*|LINUX_SRC_MODULE = '$INSTALL'/lib/modules/'$(get_module_dir)'/kernel/drivers/net/wireless/|' Makefile
  make osdrv
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/modules/$(get_module_dir)/$PKG_NAME
    cp os/linux/mt7610u_sta.ko $INSTALL/lib/modules/$(get_module_dir)/$PKG_NAME

  mkdir -p $INSTALL/lib/firmware/mt7610u
    cp RT2870STA.dat $INSTALL/lib/firmware/mt7610u/mt7610u_sta.dat
}
