#!/bin/sh

################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.ru
#      Copyright (C) 2011-2015 Alexandr Zuyev (alex@alexelec.ru)
################################################################################

URL=$1

  if [ -z $URL ]; then
      exit 1
  fi

TMPDIR="/tmp/infostream"
FF_TEMP="$TMPDIR/ffmpeg.log"
cnt="true"

mkdir -p $TMPDIR
rm -rf $TMPDIR/*

[ "$(pidof ffmpeg)" ] && killall -9 ffmpeg > /dev/null 2>&1

(
ffmpeg -i $URL 2>&1 | grep -A 6 'Duration' | \
  sed '1d; s/^[ \t]*//; s/[ \t]*$//; s/://g; s/#0[0-9]//g; \
  s/(...)//; s/Metadata.*//; s/service_provider.*//; s/service_name.*//; /^$/d' | \
  awk '{print $1,"=",$2,"#",$3}' > $FF_TEMP
) &

sleep 3

  if [ "$(pidof ffmpeg)" ]; then
      sleep 3
      [ "$(pidof ffmpeg)" ] && sleep 3
      killall -9 ffmpeg > /dev/null 2>&1
  fi

  if [ ! -s $FF_TEMP ]; then
      echo "STREAM=0"
      exit 1
  else
      echo "STREAM=1"
  fi

cat $FF_TEMP |  
    while read -r LINE ; do
        STR=`echo $LINE | awk '{print $1}'`

        case $STR in
          "Program" )
              PROG=`echo $LINE | awk '{print $3}'`
              echo "EPG_ID=$PROG"
           ;;
          "Stream" )
              AV=`echo $LINE | awk -F'#' '{print $2}'`
              CODE_HEX=`echo $LINE | awk '{print $3}' | sed ' s/\[//; s/\]//'`              
              if [ $AV = "Video" ]; then
                  CODE_DEM=`printf "%d\n" $CODE_HEX`
                  echo "VIDEO_ID=$CODE_DEM"
              elif [ $AV = "Audio" ]; then
                  if [ $cnt = "true" ]; then
                      CODE_DEM=`printf "%d\n" $CODE_HEX`
                      echo "AUDIO_ID=$CODE_DEM"
                      cnt="false"
                  fi
              fi        
           ;;
        esac
    done

exit 0
