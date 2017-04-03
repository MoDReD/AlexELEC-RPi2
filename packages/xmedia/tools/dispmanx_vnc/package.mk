################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="dispmanx_vnc"
PKG_VERSION="78e6673"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="https://github.com/patrikolausson/dispmanx_vnc"
PKG_GIT_URL="https://github.com/patrikolausson/dispmanx_vnc.git"
PKG_GIT_BRANCH="master"
PKG_DEPENDS_TARGET="toolchain libvncserver bcm2835-bootloader bcm2835-driver libconfig libressl"
PKG_PRIORITY="optional"
PKG_SECTION="service/system"
PKG_SHORTDESC="VNC Server for Raspberry Pi"
PKG_LONGDESC="VNC Server for Raspberry Pi using dispmanx"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_make_target() {
  export SYSROOT_PREFIX
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp -p $ROOT/$PKG_BUILD/dispmanx_vncserver $INSTALL/usr/bin
    cp $PKG_DIR/scripts/* $INSTALL/usr/bin
}

post_install() {
  enable_service vncserver.service
}
