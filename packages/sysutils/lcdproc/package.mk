################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="lcdproc"
PKG_VERSION="0.5.7-cvs20140217"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://lcdproc.org/"
# PKG_URL="$SOURCEFORGE_SRC/lcdproc/lcdproc/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain libusb libhid libftdi1"
PKG_PRIORITY="optional"
PKG_SECTION="system"
PKG_SHORTDESC="lcdproc: Software to display system information from your Linux/*BSD box on a LCD"
PKG_LONGDESC="LCDproc is a piece of software that displays real-time system information from your Linux/*BSD box on a LCD. The server supports several serial devices: Matrix Orbital, Crystal Fontz, Bayrad, LB216, LCDM001 (kernelconcepts.de), Wirz-SLI, Cwlinux(.com) and PIC-an-LCD; and some devices connected to the LPT port: HD44780, STV5730, T6963, SED1520 and SED1330. Various clients are available that display things like CPU load, system load, memory usage, uptime, and a lot more."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

if [ "$IRSERVER_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET irserver"
fi

IFS=$','
for i in $LCD_DRIVER; do
  case $i in
    glcd) PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET serdisplib"
      ;;
    *)
  esac
done
unset IFS

PKG_CONFIGURE_OPTS_TARGET="--enable-libusb --enable-drivers=$LCD_DRIVER,!curses,!svga --enable-seamless-hbars"

pre_make_target() {
  # dont build parallel
    MAKEFLAGS=-j1
}

post_makeinstall_target() {
  rm -rf $INSTALL/etc/lcd*.conf
  rm -rf $INSTALL/usr/bin

  sed -e "s|^DriverPath=.*$|DriverPath=/usr/lib/lcdproc/|" \
      -e "s|^Driver=.*$|Driver=irtrans|" \
      -e "s|^#Foreground=.*$|Foreground=no|" \
      -e "s|^#ServerScreen=.*$|ServerScreen=blank|" \
      -e "s|^#Backlight=.*$|Backlight=open|" \
      -e "s|^#Heartbeat=.*$|Heartbeat=open|" \
      -e "s|^#TitleSpeed=.*$|TitleSpeed=4|" \
      -e "s|^#Hello=\"  Welcome to\"|Hello=\"Welcome to\"|" \
      -e "s|^#Hello=\"   LCDproc!\"|Hello=\"$DISTRONAME\"|" \
      -e "s|^#GoodBye=\"Thanks for using\"|GoodBye=\"Thanks for using\"|" \
      -e "s|^#GoodBye=\"   LCDproc!\"|GoodBye=\"$DISTRONAME\"|" \
      -e "s|^#normal_font=.*$|normal_font=/usr/share/fonts/liberation/LiberationMono-Bold.ttf|" \
      -i $INSTALL/etc/LCDd.conf

    mkdir -p $INSTALL/usr/lib/alexelec
      cp $PKG_DIR/scripts/lcd-wrapper $INSTALL/usr/lib/alexelec

}

post_install() {
  enable_service lcdd.service
}
