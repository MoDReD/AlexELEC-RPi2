#!/bin/sh
################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.ru
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.ru)
################################################################################

. /etc/profile

trap cleanup TERM

SAVED_ARGS="$@"
CRASHLOG_DIR=/storage/.kodi/temp
SERVICE_DIR=/storage/.cache/services
LOCK_DIR=/var/lock

cleanup() {
  # make systemd happy by not exiting immediately but
  # wait for kodi to exit
  while killall -0 kodi.bin &>/dev/null; do
    sleep 0.5
  done
}

command_exists()
{
  command -v $1 &>/dev/null
}

single_stacktrace()
{
  # core filename is "core.*kodi.bin.*"
  find "$1" -name 'core.*kodi.bin.*' | while read core; do
    echo "=====>  Core file: "$core"" >> $FILE
    echo "        =========================================" >> $FILE
    gdb /usr/lib/kodi/kodi.bin --core="$core" --batch -ex "thread apply all bt" 2>/dev/null >> $FILE
    rm -f "$core"
  done
}

print_crash_report()
{
  if [ ! -d $CRASHLOG_DIR ] ; then
    mkdir -p $CRASHLOG_DIR
  fi
  DATE=`date +%Y%m%d%H%M%S`
  FILE="$CRASHLOG_DIR/.kodi_crashlog.log"
  echo "############## kodi CRASH LOG ###############" > $FILE
  echo >> $FILE
  echo "################ SYSTEM INFO ################" >> $FILE
  echo -n " Date: " >> $FILE
  date >> $FILE
  echo " kodi Options: $SAVED_ARGS" >> $FILE
  echo -n " Arch: " >> $FILE
  uname -m >> $FILE
  echo -n " Kernel: " >> $FILE
  uname -rvs >> $FILE
  echo -n " Release: " >> $FILE
  . /etc/os-release
  echo $NAME $VERSION >> $FILE
  echo "############## END SYSTEM INFO ##############" >> $FILE
  echo >> $FILE
  echo "############### STACK TRACE #################" >> $FILE
  if command_exists gdb; then
    single_stacktrace /storage/.cache/cores
  else
    echo "gdb not installed, can't get stack trace." >> $FILE
  fi
  echo "############# END STACK TRACE ###############" >> $FILE
  echo >> $FILE
  echo "################# LOG FILE ##################" >> $FILE
  echo >> $FILE
  cat /storage/.kodi/temp/kodi.log >> $FILE
  echo >> $FILE
  echo "############### END LOG FILE ################" >> $FILE
  echo >> $FILE
  echo "############ END kodi CRASH LOG #############" >> $FILE
  OFILE="$FILE"
  FILE="$CRASHLOG_DIR/kodi_crashlog_$DATE.log"
  mv "$OFILE" "$FILE"
  echo "Crash report available at $FILE"
}

# clear RAM
clear_ram () {
  if [ -f "$SERVICE_DIR/ramclear.conf" ]; then
    RAM_IN=`free -m | grep 'Mem:' | awk '{print $4}'`

    sync
    echo 3 > /proc/sys/vm/drop_caches

    RAM_OUT=`free -m | grep 'Mem:' | awk '{print $4}'`
    if [ $RAM_OUT -gt $RAM_IN ]; then
      let RAM_CLEAR=$RAM_OUT-$RAM_IN
      logger -t memory "$RAM_CLEAR MB of memory freed"
    fi
  fi
}

# boblightd start-stop service
boblightd_run () {
  if [ -f "$SERVICE_DIR/boblightd.conf" ]; then
      systemctl $1 boblightd.service
  fi
}

# Animated splash
start_splash kodi

### STOP Emulationstation ###
if [ -f "$LOCK_DIR/stop.retro" ]; then
  rm -f $LOCK_DIR/stop.retro
  boblightd_run start
  clear_ram
  rmmod snd_bcm2835 > /dev/null 2>&1

  (
    if systemctl is-active tmp-cores.mount &>/dev/null ; then
      systemctl stop tmp-cores.mount
      systemctl stop tmp-joypads.mount
      systemctl stop tmp-database.mount
      systemctl stop tmp-assets.mount
    fi
  ) &
fi

if command_exists gdb; then
  ulimit -c unlimited
fi

# clean up any stale cores. just in case
rm -f /storage/.cache/cores/*

/usr/lib/kodi/kodi.bin $SAVED_ARGS
RET=$?

if [ $(( ($RET >= 131 && $RET <= 136) || $RET == 139 )) = "1" ] ; then
  # Crashed with core dump
  print_crash_report

  # Cleanup. Keep only youngest 10 reports
  rm -f $(ls -1t $CRASHLOG_DIR/kodi_crashlog_*.log | tail -n +11)
fi

clear_ram
exit $RET
