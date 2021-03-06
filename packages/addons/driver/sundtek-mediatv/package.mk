################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.ru
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.ru)
################################################################################

PKG_NAME="sundtek-mediatv"
PKG_VERSION="6.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="nonfree"
PKG_SITE="http://support.sundtek.com/"
PKG_URL=""
PKG_DEPENDS_TARGET=""
PKG_PRIORITY="optional"
PKG_SECTION="driver/dvb"
PKG_SHORTDESC="Sundtek USB Stick DVB userspace driver"
PKG_LONGDESC="Driver for Sundtek MediaTV Pro (DVB-C, DVB-T, AnalogTV, Composite, S-Video, FM-Radio USB Stick) and Sundtek SkyTV Ultimate (DVB-S/S2 USB)."
PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_PROVIDES=""
PKG_AUTORECONF="no"

make_target() {
  mkdir -p $ROOT/$PKG_BUILD
  cd $ROOT/$PKG_BUILD

  case $TARGET_ARCH in
    x86_64)
      INSTALLER_URL="http://sundtek.de/media/netinst/64bit/installer.tar.gz"
      ;;
    arm)
      INSTALLER_URL="http://sundtek.de/media/netinst/armsysvhf/installer.tar.gz"
      ;;
  esac
  
  wget -O installer.tar.gz $INSTALLER_URL
  
  tar -xzf installer.tar.gz
  
  chmod -R 755 opt/ etc/
  
  rm -f  opt/bin/getinput.sh
  rm -f  opt/bin/lirc.sh
  rm -fr opt/lib/pm/

  wget -O version.used http://sundtek.de/media/latest.phtml
}

makeinstall_target() {
  : # nothing to do here
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config/
  cp -P $PKG_DIR/config/* $ADDON_BUILD/$PKG_ADDON_ID/config/
  cp -P $PKG_DIR/settings-default.xml $ADDON_BUILD/$PKG_ADDON_ID/
  cp -Pa $PKG_BUILD/opt/bin $ADDON_BUILD/$PKG_ADDON_ID/
  cp -Pa $PKG_BUILD/opt/lib $ADDON_BUILD/$PKG_ADDON_ID/
  cp $PKG_BUILD/version.used $ADDON_BUILD/$PKG_ADDON_ID/
}
