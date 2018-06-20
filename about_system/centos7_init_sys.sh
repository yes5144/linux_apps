#!/usr/bin/env bash
# coding: utf8
# author: channel
# 1006793841@qq.com
#
# 1/ close selinux
setenforce 0
sed -i /SELINUX/s/enforcing/disabled/g /etc/selinux/config

# 2/ close iptables
systemctl stop iptables.service
systemctl stop firewalld.service

# 3/ yum some tools
yum groupinstall "Development Tools" "Compatibility Libraries" "Chinese Support [zh]" -y
yum -y install tree wget vim man ntpdate lrzsz dos2unix net-tools
yum -y install gcc gcc-c++ openssl-devel zlib-devel

# 4/ configure epel aliyun
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo

# 5/ sync time
ntpdate times.aliyun.com
echo '# time sync to aliyun 2017-08-21' >> /var/spool/cron/root
echo '*/5 * * * * /usr/sbin/ntpdate times.aliyun.com >/dev/null 2>&1' >>/var/spool/cron/root

# 6/ add a user

# 7/ Optimization of system parameters
echo "* - nofile 65535" >>/etc/security/limits.conf

# 8/ ssh
\cp /etc/ssh/sshd_config{,.bak}
sed -i 's@#UseDNS yes@UseDNS no@g;s@^GSSAPIAuthentication yes@GSSAPIAuthentication no@g' /etc/ssh/sshd_config
#sed -i 's@#PermitRootLogin yes@PermitRootLogin no@g' /etc/ssh/sshd_config
#sed -i 's@#Port 22@Port 52222@g' /etc/ssh/sshd_config
/etc/init.d/sshd reload

# 9/ 
