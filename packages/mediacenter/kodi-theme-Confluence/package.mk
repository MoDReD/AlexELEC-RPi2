################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="kodi-theme-Confluence"
PKG_VERSION="16.1-c6f6e0b"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL="$ALEXELEC_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain kodi"
PKG_PRIORITY="optional"
PKG_SECTION="mediacenter"
PKG_SHORTDESC="kodi-theme-Confluence: Kodi Mediacenter default theme"
PKG_LONGDESC="Kodi Media Center (which was formerly named Xbox Media Center and XBMC) is a free and open source cross-platform media player and home entertainment system software with a 10-foot user interface designed for the living-room TV. Its graphical user interface allows the user to easily manage video, photos, podcasts, and music from a computer, optical disk, local network, and the internet using a remote control."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  TexturePacker -input media/ \
                -output Textures.xbt \
                -dupecheck \
                -use_none
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/kodi/addons/skin.confluence
    cp -R */ $INSTALL/usr/share/kodi/addons/skin.confluence
    cp *.txt $INSTALL/usr/share/kodi/addons/skin.confluence
    cp *.xml $INSTALL/usr/share/kodi/addons/skin.confluence
    cp *.png $INSTALL/usr/share/kodi/addons/skin.confluence
      rm -rf $INSTALL/usr/share/kodi/addons/skin.confluence/media

  mkdir -p $INSTALL/usr/share/kodi/addons/skin.confluence/media
    cp Textures.xbt $INSTALL/usr/share/kodi/addons/skin.confluence/media

# Rebrand
  sed -e "s,@DISTRONAME@,$DISTRONAME,g" -i $INSTALL/usr/share/kodi/addons/skin.confluence/720p/IncludesHomeMenuItems.xml
}
