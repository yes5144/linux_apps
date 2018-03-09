#!/bin/bash
#

Date=$(date +%F" "%H:%M)
Ip=$(hostname -I)
Mail="1006793841@qq.com"
Total=$(fdisk -l |awk -F'[: ]+' 'BEGIN{OFS="="}/^Disk \/dev/{printf "%s=%sG,",$2,$3}')
Part_Use=$(df -h |awk 'BEGIN{OFS="="}/^/dev/{print $1,int($5),$6}')
for i in $Part_Use; do
	Part=$(echo $i| cut -d"=" -f1)
	Use=$(echo $i| cut -d"=" -f2)
	Mount=$(echo $i |cut -d"=" -f3)
	if [ $Use -gt 80 ]; then
		echo "
		Date: $Date
		Host: $Ip
		Total: $Total
		Problem: $Part=$Use($Mount)
		" |mail -s "Disk Monitor" $Mail

	fi
done


