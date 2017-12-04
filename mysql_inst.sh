#!/bin/bash
# description mysql rpm install
#

MYSQL_DIR=mysql-5.5.54-linux2.6-x86_64
MYSQL_FILE=${MYSQL_DIR}.tar.gz
MYSQL_URL=http://mirrors.sohu.com/mysql/MySQL-5.5/${MYSQL_FILE}

[ -d "/usr/local/mysql" ] && echo 'mysql exist' && exit

[ ! -f ${MYSQL_FILE} ] && wget -c ${MYSQL_URL} || echo "dont need down mysql"

# 安装mysql：
#ln -s /usr/local/mysql-5.5.54/ /usr/local/mysql
tar xf ${MYSQL_FILE}
mv ${MYSQL_DIR} /usr/local/mysql

#########相当于make install完成#########
# 创建用户和目录
useradd mysql -s /sbin/nologin -M
chown -R mysql.mysql /usr/local/mysql/data

## 初始化数据库
cd /usr/local/mysql
./scripts/mysql_install_db \
	--user=mysql \
	--basedir=/usr/local/mysql \
	--datadir=/usr/local/mysql/data/

[ -f /etc/my.cnf ] && mv /etc/my.cnf /etc/my.cnf.bak
cp support-files/my-small.cnf /etc/my.cnf

cp support-files/mysql.server /etc/init.d/mysqld
chmod +x /etc/init.d/mysqld 
ln -s /usr/local/mysql/bin/* /usr/local/sbin/

### add system ###
chkconfig mysqld on
/etc/init.d/mysqld start

