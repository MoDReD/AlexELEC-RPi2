################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.ru
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.ru)
################################################################################

PKG_NAME="unrar"
PKG_VERSION="4.2.4"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="free"
PKG_SITE="http://www.rarlab.com"
PKG_URL="http://www.rarlab.com/rar/unrarsrc-$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="${PKG_NAME}"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="compress"
PKG_SHORTDESC="unrar: Extract, test and view RAR archives"
PKG_LONGDESC="Unrar is a package to handle files compressed in the RAR format. Due to strange licensing issues this package can only view, test and extract files in a given archive, but not pack files. But since we have far more advanced open-source compression utils it should be enough to extract the content when you get a RAR archive."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  make CXX="$TARGET_CXX" \
     CXXFLAGS="$TARGET_CXXFLAGS" \
     RANLIB="$TARGET_RANLIB" \
     AR="$TARGET_AR" \
     STRIP="$TARGET_STRIP" \
     -f makefile.unix
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp unrar $INSTALL/usr/bin
    $STRIP $INSTALL/usr/bin/unrar
}
