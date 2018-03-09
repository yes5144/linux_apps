#!/bin/bash
#
Date=$(date +%F" "%H:%M)
Ip=$(hostname -I)
Mail="1006793841@qq.com"
Total=$(free -m |awk '/Mem/{print $2}')
Use=$(free -m |awk 'Mem/{print $3-$6-$7}')
Free=$(($Total-$Use))

if [ $Free -lt 1024 ];then
	echo "
	Date: $Date
	Host: $Ip
	Problem: Total=$Total, Use=$Use, Free=$Free
	" |mail -s "memry monitor" $Mail
fi

