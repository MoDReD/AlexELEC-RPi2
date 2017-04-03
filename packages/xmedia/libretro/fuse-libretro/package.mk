################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="fuse-libretro"
PKG_VERSION="125eae0"
PKG_GIT_URL="https://github.com/libretro/fuse-libretro.git"
PKG_GIT_BRANCH="master"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/fuse-libretro"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/libretro"
PKG_SHORTDESC="A port of the Fuse Unix Spectrum Emulator to libretro "
PKG_LONGDESC="A port of the Fuse Unix Spectrum Emulator to libretro "
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  make platform=rpi2 -f Makefile.libretro
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp fuse_libretro.so $INSTALL/usr/lib/libretro/
}
