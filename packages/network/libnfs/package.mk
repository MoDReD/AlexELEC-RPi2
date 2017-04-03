################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="libnfs"
PKG_VERSION="1.10.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/sahlberg/libnfs"
PKG_URL="https://sites.google.com/site/libnfstarballs/li/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="network"
PKG_SHORTDESC="libnfs: a client library for accessing NFS shares over a network."
PKG_LONGDESC="LIBNFS is a client library for accessing NFS shares over a network."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-examples --disable-tirpc"

pre_configure_target() {
# dont build parallel
  MAKEFLAGS=-j1

  export CFLAGS="$CFLAGS -D_FILE_OFFSET_BITS=64 -I$ROOT/$PKG_BUILD/mount -I$ROOT/$PKG_BUILD/nfs"
}
