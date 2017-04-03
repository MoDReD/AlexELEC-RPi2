################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="intltool"
PKG_VERSION="0.51.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnome.org"
PKG_URL="http://launchpad.net/intltool/trunk/$PKG_VERSION/+download/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="ccache:host"
PKG_PRIORITY="optional"
PKG_SECTION="devel"
PKG_SHORTDESC="intltool: Gnome international tools"
PKG_LONGDESC="The Gnome international tools help to handle translation strings from various source files (.xml.in, .glade, .desktop.in, .server.in, .oaf.in)."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_makeinstall_host() {
  mkdir -p  $SYSROOT_PREFIX/usr/share/aclocal
    cp ../intltool.m4 $SYSROOT_PREFIX/usr/share/aclocal
}
