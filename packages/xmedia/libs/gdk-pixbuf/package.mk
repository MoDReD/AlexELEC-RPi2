################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="gdk-pixbuf"
PKG_VERSION="2.28.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.gtk.org/"
PKG_URL="http://ftp.acc.umu.se/pub/gnome/sources/gdk-pixbuf/2.28/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain glib libjpeg-turbo libpng jasper tiff"
PKG_PRIORITY="optional"
PKG_SECTION="xmedia/libs"
PKG_SHORTDESC="gdk-pixbuf: a GNOME library for image loading and manipulation."
PKG_LONGDESC="gdk-pixbuf (GdkPixbuf) is a GNOME library for image loading and manipulation. The GdkPixbuf documentation contains both the programmer's guide and the API reference."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="gio_can_sniff=yes \
            --sysconfdir=/etc \
            --localstatedir=/var \
            --disable-gtk-doc \
            --disable-gtk-doc-html \
            --disable-gtk-doc-pdf \
            --disable-man \
            --with-libpng \
            --with-libjpeg \
            --with-libtiff \
            --with-libjasper"

post_makeinstall_target() {
  mkdir -p $INSTALL/etc/gdk_pixbuf-2.0
    cp $PKG_DIR/config/gdk-pixbuf.loaders $INSTALL/etc/gdk_pixbuf-2.0
}
