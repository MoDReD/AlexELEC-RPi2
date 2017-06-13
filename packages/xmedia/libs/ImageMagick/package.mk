################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="ImageMagick"
PKG_VERSION="6.9.2-7"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.imagemagick.org"
PKG_URL="$ALEXELEC_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain libpng libjpeg-turbo tiff zlib libtool:target"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/libs"
PKG_SHORTDESC="image manipulation library"
PKG_LONGDESC="ImageMagick is a software suite to create, edit, and compose bitmap images. It can read, convert and write images in a variety of formats (over 100)."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

pre_build_target() {
  mkdir -p $PKG_BUILD/.$TARGET_NAME
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$TARGET_NAME
}

configure_target() {
export ac_cv_sys_file_offset_bits=yes

./configure --host=$TARGET_NAME \
            --build=$HOST_NAME \
            --prefix=/usr \
            --sysconfdir=/etc \
            --localstatedir=/var \
            --disable-static \
            --enable-shared \
            --with-modules=no \
            --with-perl=no \
            --with-zlib=yes \
            --with-fontconfig=yes \
            --with-freetype=yes \
            --with-xml=yes \
            --with-tiff=yes \
            --with-png=yes \
            --with-jpeg=yes \
            --with-magick-plus-plus=yes \
            --without-x
}

post_pkginstall_target() {
  for i in $INSTALL $INSTALL/usr; do
      rm -rf $i/include
      rm -rf $i/lib/pkgconfig
      rm -rf $i/share/man
      rm -rf $i/share/doc
      find $i -name "*.la" -exec rm -f "{}" ";" 2>/dev/null || true
      find $i -name "*.a" -exec rm -f "{}" ";" 2>/dev/null || true
      find $i -name "*.so*T" -exec rm -f "{}" ";" 2>/dev/null || true
      # patch backups nonsense
      find $i -name "*.orig" -exec rm -f "{}" ";" 2>/dev/null || true
  done

  $STRIP `find $INSTALL -name "*.so" 2>/dev/null` 2>/dev/null || :
  $STRIP `find $INSTALL -name "*.so.[0-9]*" 2>/dev/null` 2>/dev/null || :
}