################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="ljalves"
PKG_VERSION="2016-06-17"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/ljalves/linux_media"
PKG_URL="$ALEXELEC_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET=""
PKG_BUILD_DEPENDS_TARGET="toolchain linux"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/dvb"
PKG_SHORTDESC="Open Source TBS drivers from Luis Alves"
PKG_LONGDESC="Open Source TBS drivers from Luis Alves"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_make_target() {
  export KERNEL_VER=$(get_module_dir)
  # dont use our LDFLAGS, use the KERNEL LDFLAGS
  export LDFLAGS=""
}

make_target() {
  cd media_build
  make dir DIR=../media
  make VER=$KERNEL_VER SRCDIR=$(kernel_path) distclean
  make VER=$KERNEL_VER SRCDIR=$(kernel_path)
}

makeinstall_target() {
  : # not
}

post_install() {
  MOD_VER=`ls $BUILD/linux*/.install_pkg/lib/modules`

  # install TBS-Open drivers
  cp -Pa $INSTALL/lib/modules/$MOD_VER $INSTALL/lib/modules/$MOD_VER-tbs
  mkdir -p $INSTALL/lib/modules/$MOD_VER-tbs/updates/tbs
  find $ROOT/$PKG_BUILD/media_build/v4l/ -name \*.ko -exec cp {} $INSTALL/lib/modules/$MOD_VER-tbs/updates/tbs \;
  echo "Open Source TBS drivers version: $PKG_VERSION" > $INSTALL/lib/modules/$MOD_VER-tbs/updates/tbs-drivers.txt

  # copy firmware
  mkdir -p $INSTALL/lib/firmware
    cp -f $PKG_DIR/firmware/* $INSTALL/lib/firmware
}
