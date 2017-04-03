#!/bin/sh

################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.ru
#      Copyright (C) 2011-2013 Alexandr Zuyev (alex@alexelec.ru)
################################################################################

GREEN="\033[1;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
ENDCOLOR="\033[0m"

usage ()
{
  echo -e $GREEN"------------------------------------------------------------------------------"$ENDCOLOR
  echo -e $YELLOW"scan-m3u: version 1.0"$ENDCOLOR
  echo -e $GREEN"------------------------------------------------------------------------------"$ENDCOLOR
  echo -e $RED"ВНИМАНИЕ:"$ENDCOLOR
  echo -e $RED"          *$ENDCOLOR Формат: scan-m3u <опции>"
  echo -e "$YELLOW          * -i $ENDCOLOR: Путь к файлу *.m3u"
  echo -e "$YELLOW          * -o $ENDCOLOR: Путь к выходному файлу (опция)"
  echo -e "$YELLOW               $ENDCOLOR  например: /storage/.config/vdr/channels.conf"
  echo -e "$YELLOW          * -u $ENDCOLOR: UDP протокол (опция, по умолчанию HTTP)"
  echo -e "$YELLOW          * -r $ENDCOLOR: Создавать новый выходной файл (опция)"
  echo -e "$YELLOW          * -n $ENDCOLOR: Начальний номер канала (опция, по умолчанию -n 1000)"
  echo -e "$YELLOW          * -s $ENDCOLOR: Сортировать каналы по алфавиту"
  echo -e "$YELLOW          * -h $ENDCOLOR: Справка"
  echo -e $GREEN"------------------------------------------------------------------------------"$ENDCOLOR
  echo -e $YELLOW"ПРИМЕРЫ:"$ENDCOLOR
  echo -e "    scan-m3u -i file.m3u$ENDCOLOR"
  echo -e "    scan-m3u -r -i file.m3u -n 500 -s -o /tmp/channels.conf$ENDCOLOR"
  echo -e $GREEN"------------------------------------------------------------------------------"$ENDCOLOR
  exit 1
}

if [ $# -eq 0 ]
then
  echo -e $RED"Вызовите утилиту с одним или более параметром"$ENDCOLOR
  usage
fi

INFO_BIN="/usr/bin/m3u_info"
TMPDIR="/tmp/m3u"
TMP_FILE="$TMPDIR/iptv.tmp"
TMP_INFO="$TMPDIR/info.tmp"
TMP_CHNUM="$TMPDIR/chnum.conf"
DLMR_HTTP="http://"
DLMR_UDP="udp://@"

mkdir -p $TMPDIR
rm -rf $TMPDIR/*

Channels ()
{
  if [ "$UDP" = "false" ]; then
        cat $1 | sed -n '/#EXTINF/p; /http/p;' | sed 's/#EXTINF:.*,//; :a; /$/N; s/\n//;' | \
        awk -F"$DLMR_HTTP" '{print $1,"@",$2}' > $TMP_FILE
        DLMR=$DLMR_HTTP
        echo -e $YELLOW"--- Proto: HTTP ---"$ENDCOLOR >&2
  else
        cat $1 | sed -n '/#EXTINF/p; /udp/p;' | sed 's/#EXTINF:.*,//; :a; /$/N; s/\n//;' | \
        awk -F"$DLMR_UDP" '{print $1,"@",$2}' > $TMP_FILE
        DLMR=$DLMR_UDP
        echo -e $YELLOW"--- Proto: UDP ---"$ENDCOLOR >&2
  fi

cat $TMP_FILE |  
    while read -r LINE ; do

        NAME=`echo $LINE | awk -F\\@ '{print $1}'`
        CH_NAME=`echo $NAME | sed 's/^[ \t]*//'`
        IP=`echo $LINE | awk -F\\@ '{print $2}'`
        URL_ORG=$DLMR`echo $IP | sed 's/^[ \t]*//'`
        
        $INFO_BIN $URL_ORG > $TMP_INFO
        . $TMP_INFO
        
        if [ "$STREAM" = "0" ]; then
            echo -e $RED"--- Stream not found for Channel: $NAME ---"$ENDCOLOR >&2
            echo "LAST_NUM=$CN_NUM" > $TMP_CHNUM
            continue
        fi

        if [ "$UDP" = "false" ]; then
            URL=`echo $URL_ORG | sed 's/:/%3A/g'`
            echo "$CH_NAME;IPTV:$CN_NUM:S=0|P=0|F=CURL|U=$URL|A=0:I:0:$VIDEO_ID:$AUDIO_ID:0:0:$EPG_ID:1:1:0" >&2
            if [ -e "$OUTPUT_FILE" ]; then
                echo "$CH_NAME;IPTV:$CN_NUM:S=0|P=0|F=CURL|U=$URL|A=0:I:0:$VIDEO_ID:$AUDIO_ID:0:0:$EPG_ID:1:1:0"
            fi
        else
            GROUP=`echo $IP | awk -F\\: '{print $1}' | sed 's/^[ \t]*//'`
            PORT=`echo $IP | awk -F\\: '{print $2}' | sed 's/^[ \t]*//'`
            echo "$CH_NAME;IPTV:$CN_NUM:S=0|P=0|F=UDP|U=$GROUP|A=$PORT:I:0:$VIDEO_ID:$AUDIO_ID:0:0:$EPG_ID:1:1:0" >&2
            if [ -e "$OUTPUT_FILE" ]; then
                echo "$CH_NAME;IPTV:$CN_NUM:S=0|P=0|F=UDP|U=$GROUP|A=$PORT:I:0:$VIDEO_ID:$AUDIO_ID:0:0:$EPG_ID:1:1:0"
            fi
        fi

        CN_NUM=$( expr $CN_NUM + 1 )
        echo "LAST_NUM=$CN_NUM" > $TMP_CHNUM
    done
    
    [ -f  $TMP_CHNUM ] && . $TMP_CHNUM
    CH_ADDED="$LAST_NUM"
    echo "# Added channels" > $TMP_CHNUM
    CHADD=$( expr $CH_ADDED - $CN_NUM )
    echo "CH_NUM=$CHADD" >> $TMP_CHNUM
    echo -e $YELLOW"--- Added channels: $CHADD ---"$ENDCOLOR >&2
}

OPTIND=0
INPUT_FILE=
OUTPUT_FILE=
NEW_FILE=
SORT_CH=
CN_NUM=
F_NUM=
UDP=

GETOPT=`getopt -o i:o:n:ursh -n 'scan-m3u' -- "$@"`
[ $? != 0 ] && exit 1
eval set -- "$GETOPT"
while true ; do
  case $1 in
    -i)
        if [ ! -e "$2" ]; then
            echo -e "$REDФайл <$2> не найден!$ENDCOLOR" >&2
            exit 2
        fi
        INPUT_FILE="$2"
        shift 2
        ;;
    -o) 
        OUTPUT_FILE="$2"
        shift 2
        ;;
    -n) 
        CN_NUM="$2"
        shift 2
        ;;
    -u) 
        UDP="true"
        shift
        ;;
    -r) 
        NEW_FILE="true"
        shift
        ;;
    -s)
        SORT_CH="true"
        shift
        ;;
    -h)
        usage
        shift
        ;;
    --)
        shift
        break
        ;;
    *)
        echo "Internal error!"
        exit 1
        ;;
  esac
done

[ -z "$CN_NUM" ] && CN_NUM=1000
[ -z "$UDP" ] && UDP="false"

  if [ -z "$OUTPUT_FILE" ]; then
      Channels $INPUT_FILE
  else
      if [ "$NEW_FILE" = "true" ]; then
          echo ":IPTV Channels" > $OUTPUT_FILE
      else
          echo ":IPTV Channels" >> $OUTPUT_FILE
      fi

      if [ "$SORT_CH" = "true" ]; then
          Channels $INPUT_FILE >> $OUTPUT_FILE.sort
          sort -k1 $OUTPUT_FILE.sort >> $OUTPUT_FILE
          rm -f $OUTPUT_FILE.sort
      else
          Channels $INPUT_FILE >> $OUTPUT_FILE
      fi

  fi

exit 0
