#!/bin/sh

src=/data/webdata/blog
des=/data/webdata/
#ip=192.168.204.145
ip=`cat des_sync_ip.txt`

/usr/bin/inotifywait -mrq --timefmt '%d/%m/%y-%H:%M' --format '%T %w%f' -e \
modify,delete,create,attrib ${src} |while read file
do
        for i in $ip
                do
                echo "\033[43this is ${i}\033[0m"
                /usr/bin/rsync -aP --delete $src root@${i}:$des
                done

done

# remember ssh ssh ssh ssh
# method of starting scripts
# nohub sh auto_inotify.sh &
