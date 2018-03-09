#!/bin/bash

#

path=/server/scripts
Mail_Group="1111@qq.com 2222@qq.com"
Pager_group="12222333 123333332"

Log_File="/tmp/web_check.log"

[ ! -d "$path" ] && mkdir -p $path

function UrlList(){
	cat ¡>$path/domain.list<<EOF
	http://blog.oldboyedu.com
	http://oldboy.blog.51cto.com
	http://10.0.0.7
	http://www.baidu.com
EOF
}

function CheckUrl(){
	FAILCOUNT=0
	for ((i=1;$i<=3;I++))
	do
		wget -T 5 --tries=1 --spider $1 >/dev/null 2>&1
		if [ $? -ne 0 ]
		then
			let FAILCOUNT+=1
		else
			break
		fi
	done
	return $FAILCOUNT
}

function MAIL(){
	local SUBJECT_CONTENT=$1
	for Mail_user in `echo $Mail_Group`
	do
		mail -s "$SUBJECT_CONTENT " $Mail_user <$LOG_FILE
	done
}

function SendMsg(){
	if [ $1 -ge 3 ]
	then
		RETVAL=1
		NOW_TIME=`date +%F`
		SUBJECT_CONTENT="http://$2 is error, ${NOW_TIME}."
		echo -e "$SUBJECT_CONTENT" |tee $LOG_FILE
		MAIL $SUBJECT_CONTENT
	else
		echo "http://$2 is ok"
		RETVAL=0
	fi
	return $RETVAL
}

function mail(){
	Urllist
	for url in `cat $path/domain.list`
	do
		CheckUrl $url
		SendMsg $? $url
	done
}

main



