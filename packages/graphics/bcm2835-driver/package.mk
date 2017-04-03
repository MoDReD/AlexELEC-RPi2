################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="bcm2835-driver"
PKG_VERSION="d8c7424"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.broadcom.com"
PKG_URL="$ALEXELEC_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
#PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="graphics"
PKG_SHORTDESC="OpenMAX-bcm2835: OpenGL-ES and OpenMAX driver for BCM2835"
PKG_LONGDESC="OpenMAX-bcm2835: OpenGL-ES and OpenMAX driver for BCM2835"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$TARGET_FLOAT" = "softfp" -o "$TARGET_FLOAT" = "soft" ]; then
  FLOAT="softfp"
elif [ "$TARGET_FLOAT" = "hard" ]; then
  FLOAT="hardfp"
fi

make_target() {
  mkdir -p $SYSROOT_PREFIX
    cp -a $FLOAT/opt $SYSROOT_PREFIX
  # copy include
  mkdir -p $SYSROOT_PREFIX/usr/include
    cp -PRv $FLOAT/opt/vc/include/* $SYSROOT_PREFIX/usr/include
    cp -PRv $FLOAT/opt/vc/include/interface/vcos/pthreads/* $SYSROOT_PREFIX/usr/include/interface/vcos
    # fix for SDL2
    cp -PRv $FLOAT/opt/vc/include/interface/vmcs_host/linux/vchost_config.h $SYSROOT_PREFIX/usr/include/interface/vmcs_host

  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libEGL.so $SYSROOT_PREFIX/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libGLESv2.so $SYSROOT_PREFIX/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libbcm_host.so $SYSROOT_PREFIX/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libcontainers.so $SYSROOT_PREFIX/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libopenmaxil.so $SYSROOT_PREFIX/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libvchiq_arm.so $SYSROOT_PREFIX/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libvcos.so $SYSROOT_PREFIX/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libmmal.so $SYSROOT_PREFIX/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libmmal_components.so $SYSROOT_PREFIX/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libmmal_core.so $SYSROOT_PREFIX/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libmmal_util.so $SYSROOT_PREFIX/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libmmal_vc_client.so $SYSROOT_PREFIX/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libvcsm.so $SYSROOT_PREFIX/usr/lib
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/sbin
    cp -PRv $FLOAT/opt/vc/sbin/vcfiled $INSTALL/usr/sbin

  mkdir -p $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libEGL.so $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libGLESv2.so $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libbcm_host.so $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libcontainers.so $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libopenmaxil.so $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libvchiq_arm.so $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libvcos.so $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libmmal.so $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libmmal_components.so $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libmmal_core.so $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libmmal_util.so $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libmmal_vc_client.so $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libvcsm.so $INSTALL/usr/lib

# some usefull debug tools
  mkdir -p $INSTALL/usr/bin
    cp -PRv $FLOAT/opt/vc/bin/vcdbg $INSTALL/usr/bin
      cp -PRv $FLOAT/opt/vc/lib/libdebug_sym.so $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/bin/vcgencmd $INSTALL/usr/bin
    cp -PRv $FLOAT/opt/vc/bin/tvservice $INSTALL/usr/bin
    cp -PRv $FLOAT/opt/vc/bin/edidparser $INSTALL/usr/bin
# video splash
  mkdir -p $INSTALL/usr/share/splash
    cp -PRv $PKG_DIR/scripts/* $INSTALL/usr/bin
    cp -PRv $PKG_DIR/splash/* $INSTALL/usr/share/splash

  mkdir -p $INSTALL/opt/vc
    ln -sf /usr/lib $INSTALL/opt/vc/lib
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/share/services
    cp -P $PKG_DIR/default.d/*.conf $INSTALL/usr/share/services
}

post_install() {
  enable_service fbset.service
  enable_service unbind-console.service
  enable_service splash-defaults.service
}
