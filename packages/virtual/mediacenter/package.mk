################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="mediacenter"
PKG_VERSION=""
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.alexelec.in.ua"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain $MEDIACENTER $MEDIACENTER-theme-$SKIN_DEFAULT"
PKG_PRIORITY="optional"
PKG_SECTION="virtual"
PKG_SHORTDESC="Mediacenter: Metapackage"
PKG_LONGDESC=""
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

for i in $SKINS; do
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $MEDIACENTER-theme-$i"
done

# some python stuff needed for various addons
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET Pillow"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET simplejson"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pycrypto"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET xmlstarlet"

# system config addons
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET rpi.system.settings"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET rpi.advanced.settings"

  if [ "$KODI_LANGUAGE_ADDONS" = "yes" ]; then
    PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET kodi-language-addons"
  fi

# kodi-binary-addons pvr
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pvr.dvbviewer"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pvr.dvblink"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pvr.hts"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pvr.iptvsimple pvr.iptvsimple.multi"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pvr.vdr.vnsi"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pvr.vuplus"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET kodi-addon-xvdr"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pvr.stalker"

# kodi-binary-addons visualization
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET visualization.spectrum"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET visualization.waveform"

# audioencoder
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET audioencoder.flac"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET audioencoder.lame"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET audioencoder.vorbis"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET audioencoder.wav"
