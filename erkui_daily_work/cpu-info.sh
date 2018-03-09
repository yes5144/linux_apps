#!/bin/bash
#
Date=$(date +%F" "%H:%M)
Ip=$(hostname -I)
Mail=1006793841@qq.com

if ! which vmstat &>/dev/null; then
	echo "vmstat command not found,"
	echo "Please install procps package."
	exit 1
fi

US=$(vmstat |awk 'NR==3{print $13}')
SY=$(vmstat |awk 'NR==3{print $14}')
IDLE=$(vmstat |awk 'NR==3{print $15}')
WAIT=$(vmstat |awk 'NR==3{print $16}')
USE=$(($US+$SY))
if [ $USE -ge 50 ]; then
	echo "
	Date: $Date
	Host: $Ip
	Problem: CPU utilization $USE
	" |mail -s "CPU monitor" $Mail
fi


