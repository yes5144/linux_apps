#!/bin/bash
# 
# vim /etc/profile.d/login_check_and_record.sh
# log shenji 
# 
# PS1="`whoami`@`hostname`:"

history
USER_IP=`who -u am i 2>/dev/null |awk '{print $NF}' |sed -e 's/[()]//g'`

if [ "$USER_IP" = '' ]
then
USER_IP=`hostname`
fi

if [ ! -d /tmp/dbasky ]
then
mkdir /tmp/dbasky
chmod 777 /tmp/dbasky
fi

LOGNAME=$(whoami)
if [ ! -d /tmp/dbasky/${LOGNAME} ]
then
mkdir 300 /tmp/dbasky/${LOGNAME}
fi

export HISTSIZE=4096
DATE_NOW=`date "+%Y-%m-%d_%H:%M:%S"`
export HISTFILE="/tmp/dbasky/${LOGNAME}/${USER_IP}-dbasky.${DATE_NOW}"
chmod 600 /tmp/dbasky/${LOGNAME}/*dbasky* 2>/dev/null

# source /etc/profile

