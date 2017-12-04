#!/bin/bash
# description: install php-fpm
# 2017-12-04

PFPM_DIR=php-5.6.12
PFPM_FILE=${PFPM_DIR}.tar.gz
PFPM_URL=http://mirrors.sohu.com/php/${PFPM_FILE}

# after pei zhi l aliyun.epel , i find i can yum install libmcrypt,hahahah
yum install libmcrypt libmcrypt-devel bzip2-devel openssl-devel libxml2-devel pcre-devel -y
useradd -u 893 www

[ ! -f ${PFPM_FILE} ] && wget -c ${PFPM_URL}
tar xf ${PFPM_FILE}

cd ${PFPM_DIR} && ./configure --prefix=/usr/local/php5 \
 --with-mysql=mysqlnd --with-pdo-mysql=mysqlnd --with-mysqli=mysqlnd \
 --with-openssl --enable-mbstring --with-freetype-dir --with-jpeg-dir \
 --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml \
 --enable-sockets --enable-fpm --with-mcrypt --with-config-file-path=/etc \
 --with-config-file-scan-dir=/etc/php.d --with-bz2 \
 --with-fpm-user=www --with-fpm-group=www

[ $? -eq 0 ] && make && make install && echo -e "\033[41m${PFPM_FILE}\033[0m install okkk"

#cp php.ini-production /etc/php.ini
cp php.ini-production /etc/php.ini

# pei zhi php-fpm
#cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm

chmod +x /etc/init.d/php-fpm
chkconfig --add php-fpm
#chkconfig php-fpm on

# cp /usr/local/php5/etc/php-fpm.conf.default /usr/local/php5/etc/php-fpm.conf
cp /usr/local/php5/etc/php-fpm.conf.default /usr/local/php5/etc/php-fpm.conf

# modify parameter
# pm.max_children = 50
# pm.start_servers = 5
# pm.min_spare_servers = 2
# pm.max_spare_servers = 8
# pid = /usr/local/php5/var/run/php-fpm.pid


# nginx configuration file
# /usr/local/nginx/conf/nginx.conf

# location
/etc/init.d/php-fpm start

echo -e "\033[41mplease config nginx.conf\033[0m"
