#!/bin/bash

#
# only for centos6.x
#netstat |grep "ESTABLISHED" |awk -F "[ :]+" '{print $(NF-3)}' |sort| uniq -c |sort -rn -k1 |head -5
#netstat |grep "ESTABL" |awk -F "[ :]+" '{++S[$(NF-3)]}END {for (key in S) print S[key], key}' |sort -rn -k1 |head -5

#iptables -I INPUT -s 192.168.204.132 -j DROP

# 
File=$1

# expr judge this file if .log
if expr "$File" : ".*\.log" &>/dev/null 
then
	:
else
	echo "usage:$0 xxx.log"
	exit 1
fi

while True
do
	grep "ESTABLISHED" $1 |awk -F "[ :]+" '{++S[$(NF-3)]}END {for (key in S) print S[key], key}' |sort -rn -k1 |head -5 >/tmp/tmp.log
	
	while read line
	do
		ip=`echo $line|awk '{print $2}'`
		count=`echo $line| awk '{print $1}'`
		if [ $count -gt 500 ] && [ `iptables -L -n| grep "$ip"| wc -l` -lt 1 ]
		then
			iptables -I INPUT -s $ip -j DROP
			echo "$line is dropped" >> /tmp/droplist_$(date +%F).log
		fi
	done </tmp/tmp.log

	sleep 180
done


