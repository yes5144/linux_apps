#!/bin/bash

# description: install keepalived
# 2017-12-14

set -e
yum install ntpdate -y
ntpdate times.aliyun.com

KEEPALIVED_DIR=keepalived-1.2.1
KEEPALIVED_FILE=${KEEPALIVED_DIR}.tar.gz
KEEPALIVED_URL=http://www.keepalived.org/software/${KEEPALIVED_FILE}

# after pei zhi l aliyun.epel , i find i can yum install libmcrypt,hahahah
yum install openssl-devel popt-devel -y
#useradd -u 893 www

[ ! -f ${KEEPALIVED_FILE} ] && wget -c ${KEEPALIVED_URL}
tar xf ${KEEPALIVED_FILE}

cd ${KEEPALIVED_DIR} && ./configure \
  --with-kernel-dir=/usr/src/kernels/2.6.32-696.6.3.el6.x86_64/

[ $? -eq 0 ] && make && make install && echo -e "\033[41m${KEEPALIVED_FILE}\033[0m install okkk"

#cp 
cp /usr/local/etc/rc.d/init.d/keepalived /etc/init.d/
cp /usr/local/etc/sysconfig/keepalived /etc/sysconfig/

# mkdir
mkdir -p /etc/keepalived
cp /usr/local/sbin/keepalived /usr/sbin/

chkconfig keepalived on

modprobe ip_vs

cat > /etc/rc.modules<<EOF
#!/bin/sh
modprobe ip_vs
modprobe ip_vs_wrr
modprobe ip_vs_rr
EOF

chmod +x /etc/rc.modules

# configuration file
cat >/etc/keepalived/keepalived.conf<<EOF
$ cat nginx_master_keep.conf
!Configuration File For keepalived

global_defs {
  notification_email {
  root@localhost.localdomain
  }

  notification_email_from 1006793841@qq.com
  smtp_server 127.0.0.1
  smtp_connect_timeout 30
  router_id LVS_DEVEL
}

# VIP1

vrrp_instance VI_1 {
  state BACKUP
  interface eth0
  lvs_sync_daemon_inteface eth0
  virtual_router_id 61
  priority 100
  advert_int 5
  nopreempt
  authentication {
    auth_type PASS
    auth_pass 2222
  }

  virtual_ipaddress {
    192.168.204.188
  }
}

virtual_server 192.168.204.188 80 {
    delay_loop 6
    lb_algo wrr
    lb_kind DR
    persistence_timeout 60
    protocol TCP

#
    real_server 192.168.204.140 80 {
#
      weight 100
      notify_down /data/sh/nginx.sh
      TCP_CHECK {
       connect_timeout 10
       nb_get_retry 3
       delay_before_retry 3
       connect_port 80

      }
    }
}

EOF
# 

mkdir -p /data/sh/
cat >/data/sh/nginx.sh<<EOF
#!/bin/sh
/etc/init.d/keepalived stop
EOF

chmod +x /data/sh/nginx.sh

#
/etc/init.d/keepalived start


