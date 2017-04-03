################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="snes9x-next"
PKG_VERSION="00e7dff"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/snes9x-next"
PKG_GIT_URL="https://github.com/libretro/snes9x-next.git"
PKG_GIT_BRANCH="master"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/libretro"
PKG_SHORTDESC="Optimized port/rewrite of SNES9x 1.52+ to Libretro."
PKG_LONGDESC="Optimized port/rewrite of SNES9x 1.52+ to Libretro."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  make -f Makefile.libretro
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp snes9x_next_libretro.so $INSTALL/usr/lib/libretro/
}
