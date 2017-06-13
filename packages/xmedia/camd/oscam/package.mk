################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.ru
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.ru)
################################################################################

PKG_NAME="oscam"
PKG_VERSION="d6fe72c"
PKG_VERSION_NUMBER="11350"
PKG_REV="104"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.streamboard.tv/oscam/wiki"
PKG_URL="http://repo.or.cz/oscam.git/snapshot/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain pcsc-lite"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/camd"
PKG_SHORTDESC="oscam: OSCam is Open Source Conditional Access Modul."
PKG_LONGDESC="OSCam is Open Source Conditional Access Modul."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

unpack() {
  tar -xzf $SOURCES/$PKG_NAME/$PKG_VERSION.tar.gz -C $BUILD
}

configure_target() {
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DLIBUSBDIR=$SYSROOT_PREFIX/usr \
        -DWITH_SSL=0 \
        -DHAVE_LIBCRYPTO=0 \
        -DHAVE_DVBAPI=1 -DWITH_STAPI=0 \
        -DWEBIF=1 \
        -DWITH_DEBUG=0 \
        -DOPTIONAL_INCLUDE_DIR=$SYSROOT_PREFIX/usr/include \
        -DSTATIC_LIBUSB=1 \
        -DCLOCKFIX=0 \
        ..
}

makeinstall_target() {
  mkdir -p  $INSTALL/usr/config/oscam
    cp -a $PKG_DIR/config $INSTALL/usr/config/oscam

  mkdir -p  $INSTALL/usr/bin
    cp $ROOT/$PKG_BUILD/.$TARGET_NAME/oscam $INSTALL/usr/bin
    cp $ROOT/$PKG_BUILD/.$TARGET_NAME/utils/list_smargo $INSTALL/usr/bin
    cp $PKG_DIR/bin/* $INSTALL/usr/bin
}

post_install() {
  enable_service oscam-switch.service
  enable_service oscam.service
}
