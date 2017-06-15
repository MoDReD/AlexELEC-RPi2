################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2017 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="rpi.advanced.settings"
PKG_VERSION="9f9fe35"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="prop."
PKG_SITE="http://www.alexelec.in.ua"
PKG_GIT_URL="https://github.com/AlexELEC/rpi.advanced.settings.git"
PKG_DEPENDS_TARGET="toolchain Python pygobject"
PKG_PRIORITY="optional"
PKG_SECTION=""
PKG_SHORTDESC="Advanced-settings: Settings dialog for AlexELEC"
PKG_LONGDESC="Advanced-settings: is a settings dialog for AlexELEC"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_MAKE_OPTS_TARGET="DISTRONAME=$DISTRONAME ROOT_PASSWORD=$ROOT_PASSWORD"

post_makeinstall_target() {
  python -Wi -t -B $ROOT/$TOOLCHAIN/lib/python2.7/compileall.py $INSTALL/usr/share/kodi/addons/service.advanced.settings/resources/lib/ -f
  rm -rf `find $INSTALL/usr/share/kodi/addons/service.advanced.settings/resources/lib/ -name "*.py"`

  python -Wi -t -B $ROOT/$TOOLCHAIN/lib/python2.7/compileall.py $INSTALL/usr/share/kodi/addons/service.advanced.settings/oe.py -f
  rm -rf $INSTALL/usr/share/kodi/addons/service.advanced.settings/oe.py

  python -Wi -t -B $ROOT/$TOOLCHAIN/lib/python2.7/compileall.py $INSTALL/usr/share/kodi/addons/service.advanced.settings/defaults.py -f
  rm -rf $INSTALL/usr/share/kodi/addons/service.advanced.settings/defaults.py
}
