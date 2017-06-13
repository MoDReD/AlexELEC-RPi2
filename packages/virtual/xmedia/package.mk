################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="xmedia"
PKG_VERSION=""
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="various"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="virtual"
PKG_SHORTDESC="xmedia: Metapackage for installing Alex@ELEC package"
PKG_LONGDESC="xmedia is a Metapackage for installing Alex@ELEC package"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

# locale
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET kbd"

# tools
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET mc raspi2png scan-s2 boblightd"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET scan-m3u inputlirc htop davfs2"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET minidlna dispmanx_vnc"

# torrent
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET acestream-aml"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET aceproxy"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET transmission"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libtorrent-rasterbar-arm"

# camd
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET wicard oscam"

# vdr
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET vdr-all"

# tvheadend
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET tvheadend"

# retroarch
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET retroarch"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET gw-libretro"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET genesis-plus-gx"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET snes9x-next"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pcsx_rearmed"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET picodrive"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET ppsspp"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET mupen64plus-libretro"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET fba"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET fuse-libretro"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET mame2003"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET nestopia"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET craft"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET emulationstation"

# dvb drivers
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET vtuner-apps"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET media_build_cc"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET s2-liplianin"
