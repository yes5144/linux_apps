#!/bin/bash
set -e

echo -n "stop SELinux..."
setenforce 0 > /dev/null 2>&1
sed -i '/^SELINUX=/s/=.*/=disabled/' /etc/selinux/config && echo "OK"

echo -n "stop iptables fire ……"
/etc/init.d/iptables stop

echo -n "upgrate php version,默认为5.3.3的版本..."
rpm -ivh http://repo.webtatic.com/yum/el6/latest.rpm

yum install php56w php56w-gd php56w-mysql php56w-bcmath php56w-mbstring php56w-xml php56w-ldap -y

sed -i "s@;date.timezone =@date.timezone = Asia/Shanghai@g"  /etc/php.ini
sed -i "s@post_max_size = 8M@post_max_size = 32M@" /etc/php.ini
sed -i "s@max_execution_time = 30@max_execution_time = 300@" /etc/php.ini
sed -i "s@max_input_time = 60@max_input_time = 300@" /etc/php.ini
sed -i "s@;always_populate_raw_post_data = -1@always_populate_raw_post_data = -1@" /etc/php.ini


echo -n "升级MYSQL的版本,默认为5.1的版本"

rpm -ivh http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm

yum install -y mysql-server mysql-devel -y

echo -n "正在启动mysqld服务……"
service mysqld start > /dev/null 2>&1 && echo "OK"

echo -n "正在为mysql的root用户设置密码……"
mysqladmin -uroot password "123456" && echo "OK"

echo "正在执行mysql语句……"
mysql -uroot -p123456 -e "CREATE DATABASE zabbix CHARACTER SET utf8 COLLATE utf8_bin;" && echo "sucess."
mysql -uroot -p123456 -e "GRANT ALL PRIVILEGES ON zabbix.* TO zabbix@localhost IDENTIFIED BY 'zabbix';" && echo "sucess."
mysql -uroot -p123456 -e "flush privileges;"

echo "安装Zabbix"
groupadd  -g 201  zabbix
useradd  -g zabbix  -u 201 -m zabbix

yum install httpd libxml2-devel net-snmp-devel libcurl-devel -y

echo -n "正在下载zabbix源码包……"
wget http://sourceforge.net/projects/zabbix/files/ZABBIX%20Latest%20Stable/3.0.3/zabbix-3.0.3.tar.gz
echo -n "正在解压……"
tar zxvf zabbix-3.0.3.tar.gz

cd zabbix-3.0.3

/usr/bin/mysql -uzabbix -pzabbix zabbix < database/mysql/schema.sql
/usr/bin/mysql -uzabbix -pzabbix zabbix < database/mysql/images.sql
/usr/bin/mysql -uzabbix -pzabbix zabbix < database/mysql/data.sql

./configure --prefix=/usr/local/zabbix --sysconfdir=/etc/zabbix/ --enable-server --enable-agent --with-net-snmp --with-libcurl --with-mysql --with-libxml2

make &&make install

#ln -s /usr/local/zabbix/sbin/* /usr/sbin/

#cp misc/init.d/Fedora/core/zabbix_* /etc/init.d/

#chmod +x /etc/init.d/zabbix_*

#sed -i "s@BASEDIR=/usr/local@BASEDIR=/usr/local/zabbix@g" /etc/init.d/zabbix_server

#cp -r frontends/php/* /var/www/html/zabbix/

#chown -R apache.apache /var/www/html/zabbix/
