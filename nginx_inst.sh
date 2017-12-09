#!/bin/bash

# description: this is a shell to install nginx,
# 2017-12-04

# and i want to push it to my github repo
# get starting
NGINX_DIR=nginx-1.4.7
NGINX_FILE=${NGINX_DIR}.tar.gz
NGINX_URL=http://mirrors.sohu.com/nginx/${NGINX_FILE}
# http://mirrors.sohu.com/nginx/nginx-1.4.7.tar.gz

yum install openssl-devel pcre-devel -y

[ ! -f ${NGINX_FILE} ] && wget ${NGINX_URL}

tar xf ${NGINX_FILE} && cd ${NGINX_DIR}

useradd -u 222 -s /sbin/nologin www -M
./configure --user=www --group=www \
	--with-http_stub_status_module \
	--with-http_ssl_module

[ $? -eq 0 ] && make && make install &&\
	echo -e "\033[41m${NGINX_FILE}\033[0m nginx install okkk"

# make sure start with system
# echo "/usr/local/nginx/sbin/nginx" >> /etc/rc.local
