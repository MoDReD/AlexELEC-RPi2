################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="git"
PKG_VERSION="2.5.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://git-scm.com/"
PKG_URL="https://www.kernel.org/pub/software/scm/git/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain curl libressl"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="git: the fast distributed version control system"
PKG_LONGDESC="git: the fast distributed version control system."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

pre_build_target() {
  mkdir -p $PKG_BUILD/.$TARGET_NAME
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$TARGET_NAME
}

configure_target() {
ac_cv_fread_reads_directories=no \
ac_cv_snprintf_returns_bogus=no \
  ./configure --host=$TARGET_NAME \
              --build=$HOST_NAME \
              --prefix=/usr \
			  --libexecdir=/usr/lib \
			  --without-tcltk \
			  --without-python \
              --with-gitconfig=/etc/gitconfig
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/lib/perl
  rm -rf $INSTALL/usr/share/perl
}
