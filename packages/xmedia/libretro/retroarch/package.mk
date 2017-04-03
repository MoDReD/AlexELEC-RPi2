################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="retroarch"
PKG_VERSION="5d70242"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/RetroArch"
PKG_GIT_URL="https://github.com/libretro/RetroArch.git"
PKG_GIT_BRANCH="master"
PKG_DEPENDS_TARGET="toolchain bcm2835-driver samba alsa-lib freetype zlib retroarch-assets core-info retroarch-joypad-autoconfig common-shaders libretro-database ffmpeg avahi nss-mdns bluez-tools"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/libretro"
PKG_SHORTDESC="Reference frontend for the libretro API."
PKG_LONGDESC="RetroArch is the reference frontend for the libretro API. Popular examples of implementations for this API includes videogame system emulators and game engines, but also more generalized 3D programs. These programs are instantiated as dynamic libraries. We refer to these as libretro cores."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

LDFLAGS="$LDFLAGS -lm"
CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads \
                -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"

TARGET_CONFIGURE_OPTS=""
PKG_CONFIGURE_OPTS_TARGET="--disable-vg \
                           --disable-sdl \
						   --disable-x11 \
						   --enable-gles \
                           --disable-kms \
                           --enable-neon \
                           --enable-fbo \
						   --enable-zlib \
                           --enable-freetype"

pre_configure_target() {
  strip_lto
  cd $ROOT/$PKG_BUILD
}

make_target() {
  make V=1
  make -C gfx/video_filters compiler=$CC extra_flags="$CFLAGS"
  make -C audio/audio_filters compiler=$CC extra_flags="$CFLAGS"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  mkdir -p $INSTALL/etc
    cp $ROOT/$PKG_BUILD/retroarch $INSTALL/usr/bin
    cp $ROOT/$PKG_BUILD/retroarch.cfg $INSTALL/etc
  mkdir -p $INSTALL/usr/share/video_filters
    cp $ROOT/$PKG_BUILD/gfx/video_filters/*.so $INSTALL/usr/share/video_filters
    cp $ROOT/$PKG_BUILD/gfx/video_filters/*.filt $INSTALL/usr/share/video_filters
  mkdir -p $INSTALL/usr/share/audio_filters
    cp $ROOT/$PKG_BUILD/audio/audio_filters/*.so $INSTALL/usr/share/audio_filters
    cp $ROOT/$PKG_BUILD/audio/audio_filters/*.dsp $INSTALL/usr/share/audio_filters
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp $PKG_DIR/scripts/* $INSTALL/usr/bin
  mkdir -p $INSTALL/usr/config/retroarch
    cp $PKG_DIR/config/retroarch* $INSTALL/usr/config/retroarch
}
