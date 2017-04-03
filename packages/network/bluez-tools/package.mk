################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="bluez-tools"
PKG_VERSION="193ad6b"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/khvzak/bluez-tools"
PKG_URL="$LAKKA_MIRROR/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain dbus glib dbus-glib readline"
PKG_PRIORITY="optional"
PKG_SECTION="network"
PKG_SHORTDESC="A set of tools to manage bluetooth devices for linux"
PKG_LONGDESC="This is a GSoC project to implement a set of new command line tools for bluez. The project is implemented in C and uses the D-Bus interface of bluez."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

pre_configure_target() {
  export LDFLAGS="$LDFLAGS -lncurses"
}
