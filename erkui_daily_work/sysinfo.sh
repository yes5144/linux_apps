#!/bin/bash

#查看操作系统版本
[ -f "/etc/redhat-release" ] && cat /etc/redhat-release
#echo -e '\E[32m'"OS Version :"  $OSSTR
# 查看系统的类型
architecture=$(uname -m)
echo -e '\E[32m'"Architecture :"  $architecture

# 查看内核的版本
kernelrelease=$(uname -r)
echo -e '\E[32m'"Kernel Release :"  $kernelrelease

# 查看主机名
echo -e '\E[32m'"Hostname :"  $HOSTNAME

# 查看内网地址
internalip=$(hostname -I)
echo -e '\E[32m'"Internal IP :"  $internalip

# 查看外网地址
externalip=$(curl -s ipecho.net/plain)
echo -e '\E[32m'"External IP :  "$externalip

# 查看DNS
nameservers=$(cat /etc/resolv.conf | sed '1 d' | awk '{print $2}')
echo -e '\E[32m'"Name Servers :"  $nameservers

# 查看登陆的用户
who>/tmp/who
echo -e '\E[32m'"Logged In users :"  && cat /tmp/who

# 查看系统内存使用情况
echo -e '\E[32m'"Ram Usages :" 
echo -e '\E[32m'"Swap Usages :" 
#cat /tmp/ramcache | grep -v "Mem"
free -m

# 查看磁盘使用情况
#df -h| grep 'Filesystem\|/dev/sda*' > /tmp/diskusage
echo -e '\E[32m'"Disk Usages :" 
df -h

# 查看系统的负载情况
#loadaverage=$(top -n 1 -b | grep "load average:" | awk '{print $10 $11 $12}')
#loadaverage=$(uptime)
echo -e '\E[32m'"Load Average :" $(uptime)  

# 查看系统的运行时间
tecuptime=$(uptime | awk '{print $3,$4}' | cut -f1 -d,)
echo -e '\E[32m'"System Uptime Days/(HH:MM) :"  $tecuptime

