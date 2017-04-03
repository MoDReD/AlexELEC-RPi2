################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="kbd"
PKG_VERSION="1.15.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="ftp://devel.altlinux.org/legion/kbd/"
#PKG_URL="ftp://ftp.altlinux.org/pub/people/legion/kbd/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_URL="$ALEXELEC_SRC/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="system"
PKG_SHORTDESC="kbd: Keyboard and console utilities for Linux"
PKG_LONGDESC="The Linux Console Tools are a set of programs allowing the user to setup/customize your console (restricted meaning: text mode screen + keyboard only)."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_build_target() {
  mkdir -p $PKG_BUILD/.$TARGET_NAME
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$TARGET_NAME
}

configure_target() {
  ./configure  --host=$TARGET_NAME \
               --build=$HOST_NAME \
               --prefix=/usr \
               --sysconfdir=/etc \
               --datadir=/usr/share/kbd \
               --localstatedir=/var
}

make_target() {
  make
}

makeinstall_target() {
  make DESTDIR=$INSTALL install

  mkdir -p $INSTALL/usr/share/kbd/keymaps
    cp $PKG_DIR/config/ru-utf.map.gz $INSTALL/usr/share/kbd/keymaps
  mkdir -p $INSTALL/etc/profile.d
    cp $PKG_DIR/config/locale.conf $INSTALL/etc/profile.d
  mkdir -p $INSTALL/usr/config/locale
    cp $PKG_DIR/config/locale-archive $INSTALL/usr/config/locale
}
