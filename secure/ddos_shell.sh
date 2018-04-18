#!/bin/bash
#
# date: 2018-4-11
# author: channel
#
FilePath="access.log"
awk '{print $1}' $FilePath |sort -rn |uniq -c >ip_count.log
cat ip_count.log |while read text
do
	echo $text
	count= echo $text |awk '{print $1}'
	ip= echo $test |awk '{print $2}'
	if [ $count -gt 20 ]
	then
		if iptables -L |grep $ip
		then
			echo "ip address exists iptables, no add again"
		else
			echo "add $ip address in iptables"
			iptables -A INPUT -s $ip -j DROP && echo $ip >> ip_drop.log
			/etc/init.d/iptables save &> /dev/null
			/etc/init.d/iptables restart &>/dev/null
		fi
	else
		echo "no ip will be add iptables"
	fi
done

# remember to create a crontab task for this shell
