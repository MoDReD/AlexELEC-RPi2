################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="davfs2"
PKG_VERSION="1.5.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://savannah.nongnu.org/projects/davfs2"
PKG_URL="http://download.savannah.gnu.org/releases/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain neon"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="File system driver that allows you to mount a WebDAV folder"
PKG_LONGDESC="File system driver that allows you to mount a WebDAV folder."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_malloc_0_nonnull=yes --with-neon=$LIB_PREFIX"

pre_configure_target() {
  cd $ROOT/$PKG_BUILD
    cp -rf * .$TARGET_NAME
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/share
  rm -rf $INSTALL/etc/davfs2
  mkdir -p $INSTALL/usr/config/davfs2
    cp $PKG_DIR/config/* $INSTALL/usr/config/davfs2
  ln -sf /storage/.config/davfs2 $INSTALL/etc/davfs2
  mkdir -p $INSTALL/usr/bin
    cp $PKG_DIR/scripts/* $INSTALL/usr/bin
}

post_install() {
  mkdir -p $INSTALL/usr/config/davfs2/cache

  enable_service mnt-box.service
  enable_service mnt-yandex.service
}
