#!/bin/bash
#
# coding: utf8
#
# author: channel
# date: 2018-01-21
#
# mysqldump -uroot -p myworddb > /tmp/myworkdb-$(date +%F-%H-%M-%S).sql
# mysqldump -uroot -p --master-data=2 myworddb > /tmp/myworkdb-$(date +%F-%H-%M-%S).sql

# mysqldump -uroot -p --lock-all-tables --flush-logs --all-databases --master-data=2 >/backup_file/all_mysql-$(date +%F-%H-%M-%S).sql

# 
