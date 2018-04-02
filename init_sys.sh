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

# 4, yum some tools
yum groupinstall "Development tools" "Compatibility libraries" "Chinese Support [zh]" -y
yum install tree wget vim man ntpdate lrzsz dos2unix tree -y

# 5, sync time
ntpdate times.aliyun.com
echo '# time sync to aliyun 2017-08-21' >> /var/spool/cron/root
echo '*/5 * * * * /usr/sbin/ntpdate times.aliyun.com >/dev/null 2>&1' >>/var/spool/cron/root

# 6, add a proxy admin
useradd -u 521 myadmin
echo 123123 |passwd --stdin myadmin
\cp /etc/sudoers /etc/sudoers.ori
echo 'myadmin ALL=(ALL) NOPASSWD: ALL' >>/etc/sudoers
tail -l /etc/sudoers
visudo -c

# 7, Optimization of system parameters
echo "* - nofile 65535" >>/etc/security/limits.conf

#cat >>

# 8, ssh
\cp /etc/ssh/sshd_config{,.bak}
sed -i 's@#UseDNS yes@UseDNS no@g;s@^GSSAPIAuthentication yes@GSSAPIAuthentication no@g' /etc/ssh/sshd_config
sed -i 's@#PermitRootLogin yes@PermitRootLogin no@g' /etc/ssh/sshd_config
#sed -i 's@#Port 22@Port 52222@g' /etc/ssh/sshd_config
/etc/init.d/sshd reload

# 9, level 3 

