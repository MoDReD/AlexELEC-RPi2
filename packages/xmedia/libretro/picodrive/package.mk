################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="picodrive"
PKG_VERSION="e9d7e81"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/picodrive"
PKG_URL="$LAKKA_MIRROR/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain $PKG_NAME:host"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/libretro"
PKG_SHORTDESC="Libretro implementation of PicoDrive. (Sega Megadrive/Genesis/Sega Master System/Sega GameGear/Sega CD/32X)"
PKG_LONGDESC="This is yet another Megadrive / Genesis / Sega CD / Mega CD / 32X / SMS emulator, which was written having ARM-based handheld devices in mind (such as smartphones and handheld consoles like GP2X and Pandora), but also runs on non-ARM little-endian hardware too."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
  strip_gold
}

configure_host() {
  : none
}

make_host() {
  make -C ../cpu/cyclone CONFIG_FILE=../cyclone_config.h
}

makeinstall_host() {
  : none
}

configure_target() {
  : none
}

make_target() {
  make -C .. -f Makefile.libretro platform=armv6
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp ../picodrive_libretro.so $INSTALL/usr/lib/libretro/
}
