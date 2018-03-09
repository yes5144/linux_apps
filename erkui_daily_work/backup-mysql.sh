#!/bin/bash

#

PATH="/application/mysql/bin:$PATH"
DBPATH=/server/backup
MY_USER=root
MY_PASS=old123
SOCKET=/data/3306/mysql.sock
MY_CMD="mysql -u$MY_USER -p$MY_PASS -S $SOCKET"
MY_DUMP="mysqldump -u$MY_USER -p$MY_PASS -S$SOCKET"

[ ! -d "$DBPATH" ] && mkdir -p $DBPATH

for dbname in `$MYCMD -e "show databases;" |sed '1,2d' |egrep -v "mysql|schema"`
do
	$MYDUMP $dbname |gzip > $DBPATH/${dbname}_$(date +%F).sql.gz
done


