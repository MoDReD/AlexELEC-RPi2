################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="fba"
PKG_VERSION="a71055b"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/libretro-fba"
PKG_GIT_URL="https://github.com/libretro/libretro-fba.git"
PKG_GIT_BRANCH="master"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/libretro"
PKG_SHORTDESC="Port of Final Burn Alpha to Libretro."
PKG_LONGDESC="Currently, FB Alpha supports games on Capcom CPS-1 and CPS-2 hardware, SNK Neo-Geo hardware, Toaplan hardware, Cave hardware, and various games on miscellaneous hardware. "
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  if [ "$PROJECT" == "RPi2" ]; then
    make -f makefile.libretro platform=rpi2 CC=$CC CXX=$CXX profile=performance
  else
    make -f makefile.libretro CC=$CC CXX=$CXX profile=performance
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp fba_libretro.so $INSTALL/usr/lib/libretro/
}
