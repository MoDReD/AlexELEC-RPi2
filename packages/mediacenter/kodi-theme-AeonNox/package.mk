################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="kodi-theme-AeonNox"
PKG_VERSION="e6deb3b"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/BigNoid/Aeon-Nox"
PKG_GIT_URL="https://github.com/BigNoid/Aeon-Nox.git"
PKG_GIT_BRANCH="jarvis"
PKG_DEPENDS_TARGET="toolchain kodi"
PKG_PRIORITY="optional"
PKG_SECTION="mediacenter"
PKG_SHORTDESC="kodi-theme-AeonNox: Kodi Mediacenter theme"
PKG_LONGDESC="kodi-theme-AeonNox: Kodi Mediacenter theme."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  TexturePacker -input media/ \
                -output Textures.xbt \
                -dupecheck \
                -use_none

  for theme in themes/*; do
    TexturePacker -input $theme \
                -output $(basename $theme).xbt \
                -dupecheck
  done
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/config/kodi.skins/skin.aeon.nox.5ae
    cp -R */ $INSTALL/usr/config/kodi.skins/skin.aeon.nox.5ae
    cp *.txt $INSTALL/usr/config/kodi.skins/skin.aeon.nox.5ae
    cp *.xml $INSTALL/usr/config/kodi.skins/skin.aeon.nox.5ae
    cp *.png *.jpg $INSTALL/usr/config/kodi.skins/skin.aeon.nox.5ae
      rm -rf $INSTALL/usr/config/kodi.skins/skin.aeon.nox.5ae/media

  mkdir -p $INSTALL/usr/config/kodi.skins/skin.aeon.nox.5ae/media
    cp Textures.xbt $INSTALL/usr/config/kodi.skins/skin.aeon.nox.5ae/media
    for theme in themes/*; do
      cp $(basename $theme).xbt $INSTALL/usr/config/kodi.skins/skin.aeon.nox.5ae/media
    done

  mkdir -p $INSTALL/usr/share/kodi/addons
  ln -sf /storage/.config/kodi.skins/skin.aeon.nox.5ae $INSTALL/usr/share/kodi/addons/skin.aeon.nox.5ae
}

post_pkginstall_target() {
  for i in $INSTALL $INSTALL/usr; do
      rm -rf $i/include
      rm -rf $i/lib/pkgconfig
      rm -rf $i/share/man
      find $i -name "*.la" -exec rm -f "{}" ";" 2>/dev/null || true
      find $i -name "*.a" -exec rm -f "{}" ";" 2>/dev/null || true
      find $i -name "*.so*T" -exec rm -f "{}" ";" 2>/dev/null || true
      # patch backups nonsense
      find $i -name "*.orig" -exec rm -f "{}" ";" 2>/dev/null || true
  done

  find $INSTALL -type d -exec rmdir -p "{}" ";" 2>/dev/null || true

  $STRIP `find $INSTALL -name "*.so" 2>/dev/null` 2>/dev/null || :
  $STRIP `find $INSTALL -name "*.so.[0-9]*" 2>/dev/null` 2>/dev/null || :
}
