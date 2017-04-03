#!/bin/sh

################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.ru
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.ru)
################################################################################

. /etc/profile

SUNDTEK_ADDON_DIR="$HOME/.kodi/addons/driver.dvb.sundtek-mediatv"

if [ -f $SUNDTEK_ADDON_DIR/lib/libmediaclient.so ]; then
  logger -t Sundtek "### Preloading library ###"
  export LD_PRELOAD=$SUNDTEK_ADDON_DIR/lib/libmediaclient.so
else
  logger -t Sundtek "### Preloading library doesn't exist ###"
fi
