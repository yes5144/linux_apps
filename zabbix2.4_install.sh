#!/bin/bash
#
# this is zabbix2.4 for centos6
# https://www.zabbix.com/documentation/2.4/manual/installation/install_from_packages
#
# confige zabbix.repo 
rpm -ivh http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.rpm

# install
yum install zabbix-server-mysql zabbix-web-mysql

# import initial schema and data
yum install mysql mysql-server mysql-devel

# create database in mysql
mysql> create database zabbix character set utf8 collate utf8_bin;

mysql> grant all privileges on zabbix.* to zabbix@localhost identified by 'zabbix';

cd /usr/share/doc/zabbix-server-mysql-2.4.8/create
mysql -uroot zabbix < schema.sql
mysql -uroot zabbix < images.sql
mysql -uroot zabbix < data.sql

# Edit database configuration in zabbix_server.conf 
# vi /etc/zabbix/zabbix_server.conf
DBHost=localhost
DBName=zabbix
DBUser=zabbix
BPassword=zabbix

# start zabbix server
service zabbix-server start

# configue /etc/httpd/conf/zabbix.conf
php_value max_execution_time 300
php_value memory_limit 128M
php_value post_max_size 16M
php_value upload_max_filesize 2M
php_value max_input_time 300
php_value date.timezone Asia/Shanghai

#
service httpd restart

# Default username/password is Admin/zabbix

