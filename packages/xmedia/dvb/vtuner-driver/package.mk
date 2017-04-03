################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.ru
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.ru)
################################################################################

PKG_NAME="vtuner-driver"
PKG_VERSION="17"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://code.google.com/p/vtuner/"
PKG_URL="$ALEXELEC_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET=""
PKG_BUILD_DEPENDS_TARGET="toolchain linux"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/dvb"
PKG_SHORTDESC="vtuner: access DVB devices over the network."
PKG_LONGDESC="vtuner: access DVB devices over the network."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  cd $ROOT/$PKG_BUILD
  LDFLAGS="" make KDIR=$(kernel_path) CC=$CC
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/modules/$(get_module_dir)/vtuner
  find $ROOT/$PKG_BUILD/ -name \*.ko -exec strip --strip-debug {} \;
  find $ROOT/$PKG_BUILD/ -name \*.ko -exec cp {} $INSTALL/lib/modules/$(get_module_dir)/vtuner \;
}
