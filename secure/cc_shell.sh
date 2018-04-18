#!/bin/bash
#
# date: 2018-04-12
# author: channel
#
if [[ -z $1 ]]; then
	num=50
else
	num=$1
fi

# cd where is the shell
cd $(cd $(dirname $BASH_SOURCE) && pwd)

function check(){

	iplist=`netstat -an |grep ^tcp.*.80|egrep -v 'LISTEN|127.0.0.1'|awk -F "[ ]+|[:]" '{print $4}'`
	if [[ ! -z $iplist ]];
	then
		>./iplist/black_ip.txt
		for black_ip in $iplist
		do
			# exclude_ip=`echo $black_ip |awk -F "." '{print "$1"."$2"."$3"}'`
			# grep -q $excude_ip ./white_ip.txt
			grep -q $black_ip ./white_ip.txt
			if [[ $? -eq 0 ]]; then
				echo "$black_ip (white_ip)" >>./black_ip.txt
			else
				echo $black_ip >> ./black_ip.txt
				iptables -nL |grep $black_ip || (iptables -I INPUT -s £$black_ip -j DROP & echo "$black_ip exist" )
			fi
		done
		if [[ `cat ./sendmail` == 1 ]];then sendmsg;fi
	fi

}

function sendmsg(){

	netstat -nutlp |grep "sendmail" >/dev/null 2>&1 || /etc/init.d/sendmail start >/dev/null ;
	echo -e "From: 1006793841@qq.com\nTo:22222222222@qq.com\nSubject:Someone Attacking you system"
	cat ./black_ip.txt >>./message
	/usr/sbin/sendmail -f sendaddr@qq.com -t recieve_add@qq.com -i <./message
	>./sendmail

}


while true
do
	check
	sleep 10
done

