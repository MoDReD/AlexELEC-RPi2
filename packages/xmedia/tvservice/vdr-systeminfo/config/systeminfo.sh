#!/bin/sh
# systeminfo.sh: external data collection script
# This file belongs to the VDR plugin systeminfo
#
# See the main source file 'systeminfo.c' for copyright information and
# how to reach the author.
#
# $Id$
#
# possible output formats:
# (blanks around tabs only for better reading)
# 1)   Name \t Value         	displays Name and Value
# 2)   Name \t Value1 \t Value2 displays Name, Value1 and Value2
# 3)   Name \t total used       displays an additional progress bar (percentage) after the values
# 4)   s \t Name \t ...         defines a static value, this line is only requested during the first cycle
#
# special keywords (they are replaced by the plugin with the actual value):
#      CPU%    CPU usage in percent
#
# test with: for i in $(seq 1 16); do systeminfo.sh $i;echo;done
#

PATH=/usr/bin:/bin:/sbin

case "$1" in
	1)	# kernel version (static)
		KERNEL=$(uname -rmv)
		echo -ne "s\tLinux Kernel:\t\t"$KERNEL
        	;;

	2)	# distribution release (static)
		if test -f /etc/os-release; then
			. /etc/os-release
            DISTRI=$PRETTY_NAME
		else
			DISTRI="Unknown"
		fi
        echo -ne "s\tDistribution:\t\t"$DISTRI
		exit
        	;;

	3)	# CPU type (static)
		CPUTYPE=$(grep 'model name' /proc/cpuinfo | cut -d':' -f 2  | cut -d' ' -f2- | uniq)
		echo -ne "s\tCPU Type:\t\t"$CPUTYPE
        	;;

	4)	# current CPU speed
		VAR=$(($(cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq) / 1000))
		echo -ne "CPU speed:\t\t"$VAR" MHz"
		exit
        	;;

    5)	# current Display resolution
		D_RES=$(tvservice -s | awk -F'[' '{print $2}' | sed 's/]//')
		echo -ne "Display:\t\t"$D_RES
		exit
        	;;

	6)	# hostname and IP (static)
		hostname=$(hostname)
		IP=$(ifconfig eth0 | grep inet | cut -d: -f2 | cut -d' ' -f1)
        [ -z $IP ] && IP=$(ifconfig wlan0 | grep inet | cut -d: -f2 | cut -d' ' -f1)
		echo -ne "s\tHostname:\t"${hostname:-<unknown>}"\tIP: "${IP:-N/A}
		exit
        	;;

	7)	# temperature of CPU and mainboard
		CPU=$(cputemp)
		echo -ne "Temperatures:\tCPU: "$CPU
		exit
        	;;

    8)  #GPU temperature
	    GPU=$(gputemp)
		echo -e "\tGPU: "$GPU
    	exit
   	    ;;

	9)	# time and uptime
        TIME=$( echo `uptime` | awk '{ print $1 }' )
        UPTIME=$( echo `uptime` | sed 's/,/ /' | cut -d' ' -f3,4,6 )
		echo -ne "Time:\t"$TIME"\tUptime: "$UPTIME
		exit
        ;;

	10)	# header (static)
		echo -ne "s\t\ttotal / free"
		exit
		;;

	11)	# video disk usage
		VAR=$(df -Pk /storage/videos | tail -n 1 | tr -s ' ' | cut -d' ' -f 2,4)
		echo -ne "Video Disk:\t"$VAR
		exit
        ;;

	12)	# memory usage
		VAR=$( grep -E 'MemTotal|MemFree' /proc/meminfo | cut -d: -f2 | tr -d ' ')
		echo -ne "Memory:\t"$VAR
		exit
        ;;

	13)	# swap usage
		VAR=$(grep -E 'SwapTotal|SwapFree' /proc/meminfo | cut -d: -f2 | tr -d ' ')
		echo -ne "Swap:\t"$VAR
		exit
        ;;

	test)
		echo ""
		echo "Usage: systeminfo.sh {1|2|3|4|...}"
		echo ""
		exit 1
		;;
esac
exit
