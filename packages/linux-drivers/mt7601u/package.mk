################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="mt7601u"
PKG_VERSION="ae46ece"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kuba-moo/mt7601u"
PKG_URL="$ALEXELEC_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_PRIORITY="optional"
PKG_SECTION="driver"
PKG_SHORTDESC="mt7601u linux 3.19+ driver"
PKG_LONGDESC="mt7601u linux 3.19+ driver"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  KDIR=$(kernel_path) make
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/modules/$(get_module_dir)/$PKG_NAME
    cp $ROOT/$PKG_BUILD/mt7601u.ko $INSTALL/lib/modules/$(get_module_dir)/$PKG_NAME
}
