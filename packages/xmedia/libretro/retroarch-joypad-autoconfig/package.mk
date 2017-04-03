################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="retroarch-joypad-autoconfig"
PKG_VERSION="91a69a9"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/retroarch-joypad-autoconfig"
PKG_GIT_URL="https://github.com/libretro/retroarch-joypad-autoconfig.git"
PKG_GIT_BRANCH="master"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/libretro"
PKG_SHORTDESC="RetroArch joypad autoconfig files"
PKG_LONGDESC="RetroArch joypad autoconfig files"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : none
}

makeinstall_target() {
  mkdir -p $INSTALL/etc/retroarch-joypad-autoconfig
  cp -r * $INSTALL/etc/retroarch-joypad-autoconfig
}
