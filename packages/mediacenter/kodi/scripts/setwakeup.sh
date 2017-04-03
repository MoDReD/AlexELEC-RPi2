#!/bin/sh
################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.ru
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.ru)
################################################################################

if [ -f /sys/class/rtc/rtc0/wakealarm ]; then
  logger -t setwakeup.sh "### Setting system wakeup time ###"
  echo 0 > /sys/class/rtc/rtc0/wakealarm
  echo $1 > /sys/class/rtc/rtc0/wakealarm
  logger -t setwakeup.sh "### $(cat /proc/driver/rtc) ###"
fi
