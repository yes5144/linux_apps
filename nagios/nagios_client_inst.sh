#!/bin/bash

# author:channelking

NAG_DIR=nagios-3.2.1

NAG_FILE=${NAG_DIR}.tar.gz

NAG_URL=https://nchc.dl.sourceforge.net/project/nagios/nagios-3.x/nagios-3.2.1/${NAG_FILE}

useradd nagios

function nag_inst()
 {
#`echo -e "\033[31m ${NAG_FILE} installing ...\033[0m"`
[ -f $NAG_FILE ] && echo -e  "\033[31m${NAG_DIR} EXIST\033[0m" || wget $NAG_URL

tar xf $NAG_FILE && cd $NAG_DIR
./configure --prefix=/usr/local/nagios --with-command-group=nagios &>/etc/null

[ $? -eq 0 ] && make all && make install

make install-init && make install-config && make install-commandmode && make install-webconf
[ $? -eq 0 ] && echo -e "\033[33m${NAG_FILE} install completely \033[0m" || echo "failed"
}

# author:channelking

NAG_PL_DIR=nagios-plugins-1.4.14

NAG_PL_FILE=${NAG_PL_DIR}.tar.gz

NAG_PL_URL=http://down1.chinaunix.net/distfiles/${NAG_PL_FILE}

function nag_pl_inst()
 {
#echo -e "\033[31m ${NAG_PL_FILE} installing ...\033[0m"
[ -f $NAG_PL_FILE ]&& echo "${NAG_PL_DIR} EXIST" || wget $NAG_PL_URL

tar xf $NAG_PL_FILE && cd $NAG_PL_DIR
./configure --prefix=/usr/local/nagios --with-nagios-user=nagios --with-nagios-group=nagios

[ $? -eq 0 ] && make && make install

[ $? -eq 0 ] && echo -e "\033[33m ${NAG_PL_FILE} install completely \033[0m" || echo "failed"
}

# author:channelking

NRPE_DIR=nrpe-2.13

NRPE_FILE=${NRPE_DIR}.tar.gz

NRPE_URL=http://down1.chinaunix.net/distfiles/${NRPE_FILE}

function nrp_inst()
 {
echo -e "\033[31m ${NRPE_FILE} installing ...\033[0m"
[ -f $NRPE_FILE ]&& echo "${NRPE_DIR} EXIST" || wget $NRPE_URL

tar xf $NRPE_FILE && cd $NRPE_DIR
# this is nagios-plugins
#./configure --prefix=/usr/local/nagios --with-nagios-user=nagios --with-nagios-group=nagios
./configure --enable-ssl --with-ssl-lib &> /etc/null

[ $? -eq 0 ] && make all && make install-plugin && make install-daemon && make install-daemon-config &> /etc/null

[ $? -eq 0 ] && echo -e "\033[33m ${NRPE_FILE} install completely \033[0m" || echo "failed"

}

echo -e " \033[31mwill install ${NAG_FILE}\033[0m"
#nag_inst &>/etc/null

echo -e " \033[31mwill install ${NAG_PL_FILE}\033[0m"
nag_pl_inst &>/etc/null

echo -e "\033[31m will install ${NRPE_FILE} \033[0m"
nrp_inst &>/etc/null

chown -R nagios:nagios /usr/local/nagios

sed -i /allowed_hosts/s/127.0.0.1/127.0.0.1,192.168.204.166/g /usr/local/nagios/etc/nrpe.cfg

echo "start this client nrpe with \033[41mnrpe -c nrpe.cfg -d\033[0m"
