#!/bin/bash
# description: this shell is just for some experimental pc, centos 6.5mini
# 1, close iptables
/etc/init.d/iptables stop
chkconfig iptables off

# 2, close selinux
setenforce 0
sed -i /SELINUX/s/enforcing/disabled/g /etc/selinux/config

# 3, configure epel aliyun
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-6.repo

# 4, add a proxy admin
useradd -u 521 myadmin
echo 123123 |passwd --stdin myadmin

# 5, sudo add 
#echo "myadmin "

# 6, Optimization of system parameters
