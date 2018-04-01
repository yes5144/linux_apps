#!/bin/bash
#
# nfs
# nfs server soft
yum install nfs-utils rpcbind -y

# rpcbind
/etc/init.d/rpcbind start
chkconfig rpcbind on

# useradd www
useradd -u 501 -s /sbin/nologin -M www

# confige nfs conf
cat >>/etc/exports<<EOF
### shared dir at 2017-09-30
/data 192.168.204.0/24(rw,sync,all_squash,anonuid=501,anongid=501)
EOF

mkdir /data/ -p
chown -R www.www /data

/etc/init.d/nfs start
chkconfig nfs on

# check nfs
ps -ef |grep nfs
