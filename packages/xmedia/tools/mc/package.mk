################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.ru
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.ru)
################################################################################

PKG_NAME="mc"
PKG_VERSION="4.8.11"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.midnight-commander.org/"
PKG_URL="http://ftp.midnight-commander.org/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain libtool:host gettext:host glib pcre slang"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="Midnight Commander is a visual file manager"
PKG_LONGDESC="Midnight Commander is a visual file manager"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_build_target() {
  mkdir -p $PKG_BUILD/.$TARGET_NAME
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$TARGET_NAME
}

configure_target() {
export CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include/slang"
export LDFLAGS=`echo $LDFLAGS | sed -e "s|-Wl,--as-needed||"`

./configure --host=$TARGET_NAME \
            --build=$HOST_NAME \
            --target=$TARGET_NAME \
            --prefix=/usr \
            --sysconfdir=/etc \
            --without-gpm-mouse \
            --with-screen=slang \
            --enable-charset \
            --enable-background \
            --with-subshell \
            --with-edit \
            --without-x \
            fu_cv_sys_stat_statfs2_bsize=yes

}

post_install() {
  rm -rf $INSTALL/etc/mc
  mkdir -p  $INSTALL/usr/config/mc
    cp -a $PKG_DIR/etc/* $INSTALL/usr/config/mc
    ln -sf /storage/.config/mc $INSTALL/etc/mc
}
