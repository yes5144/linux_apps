#!/bin/bash

User=root
PassWord=channel
OldEpel=/etc/yum.repos.d/epel.repo
# configure epel
echo -e "\033[33******mconfiguring  aliyun.epel******\033[0m"
#[ -f known_hosts.bak ] && mv known_hosts.bak{,._$(date +%F).bak}
[ -f ${OldEpel} ] && mv ${OldEpel}{,_$(date +%F).bak}
wget -O ${OldEpel} http://mirrors.aliyun.com/repo/epel-6.repo
yum clean all -y
yum makecache

echo -e "\033[33m******install sshpass******\033[0m"
yum -y install sshpass

echo -e  "\033[33m******create id_dsa.pub key******\033[0m"
rm -rf ~/.ssh/*
ssh-keygen -t dsa -f ~/.ssh/id_dsa -P ""

for ip in $*
do
	ping $ip -c1
	if [ $? -gt 0 ];then
		echo -e  "\033[41m$ip down,,please check\033[0m"
		continue
	fi
	sshpass -p "$PassWord" ssh-copy-id -i ~/.ssh/id_dsa.pub \
	 "-o StrictHostKeyChecking=no ${User}@${ip}"
	[ $? -eq 0 ] && echo -e  "\033[32m$ip  key okk\033[0m"
done

