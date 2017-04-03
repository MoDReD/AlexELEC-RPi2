################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="harfbuzz"
PKG_VERSION="0.9.27"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.freedesktop.org/wiki/Software/HarfBuzz"
PKG_URL="http://www.freedesktop.org/software/harfbuzz/release/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain glib freetype cairo"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/libs"
PKG_SHORTDESC="harfbuzz: an OpenType text shaping engine."
PKG_LONGDESC="HarfBuzz is an OpenType text shaping engine."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--with-icu=no"
