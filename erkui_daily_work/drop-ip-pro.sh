#!/bin/bash
#

file=$1
JudgeExt(){
	if expr "$1" : ".*\.log" &>/dev/null
	then
		:
	else
		echo "Usage: $0 xxx.log"
		exit 1
	fi
}

IpCount(){
	grep "ESTABLISHED" $1 | awk -F "[ :]+" '{  ++S[$(NF-3)]} END {for(key in S) print S[key], [key]}'|sort -rn -k1 | head -5 >/tmp/tmp.log
}

ipt(){
	local ip=$1
	if [ `iptables -L -n |grep "$ip" |wc -l` -lt 1 ]
	then
		iptables  -I INPUT -s $ip -j DROP
		echo "$line is droped" >>/tmp/droplist_$(date +%F).log
	fi
}

main(){
	JudgeExt $file
	while true
	do
		IpCount $file
		while read line
		do
			ip=`echo $line |awk '{print $2}'`
			count=`echo $line |awk '{print $1}'`
			if [ $count -gt 3 ]
			then
				ipt $ip
			fi
		done </tmp/tmp.log
		sleep 180
	done
}

main

