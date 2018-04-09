# this is redis

**redis** ��һ��key-value�洢ϵͳ����memcached���ƣ����ǽ���˶ϵ��������ȫ��ʧ������֧������������string��lists��sets��zsets����Щ�������Ͷ�֧��push/pop��add/remove�Լ�ȡ��������������Ȳ���������Щ��������ԭ���Եģ�redis��֧�ָ��ֲ�ͬ������������

## ���غͰ�װ

```
cd /usr/local
wget http://download.redis.io/release/redis-4.0.2.tar.gz

tar xf redis-4.0.2.tar.gz
cd redis-4.0.2
make

mv src bin
mkdir etc
cp redis.conf etc

ln -s /usr/local/redis-4.0.2 /usr/local/redis

```

��ȫ��
���Ӹ���
������
�־û�����
����������Ϣ
�����ڴ��ʹ��

### ��ȫ�ԣ��˺ź�����

���ÿͻ������Ӻ�����κβ�������Ҫ��������

���棺��Ϊredis���ڴ������ݿ⣬�ⲿ�û�����150K/s�����볢��

```
vim /usr/local/redis/etc/redis.conf

# �ҵ� requirepass

# ָ�������ļ�����
/usr/local/redis/bin/redis-server /usr/local/redis/etc/redis.conf

# ����redis�ͻ���
redis-cli

# ������֤��¼
/usr/local/redis/bin/redis-cli -a password

127.0.0.1:6370> auth password

```


### redis.conf ˵��

```
daemonize	�����Ҫ�ں�̨���У��Ѹ����Ϊyes
pidfile 	���ö��pid�ĵ�ַ��Ĭ����/var/run/redis.pid
bind		��ip�����ú�ֻ�������Ը�ip������
port		�����˿ڣ�Ĭ��Ϊ6379
timeout		���ÿͻ�������ʱ�ĳ�ʱʱ�䣬��λ����
loglevel	��Ϊ4��debug,verbose,notice, warning
logfile		����log�ļ���ַ
database	�������ݿ�ĸ�����Ĭ��ʹ�õ����ݿ�Ϊ0
save		����redis�������ݿ⾵���Ƶ��

rdbcompression	�ڽ��о��񱸷�ʱ���Ƿ����ѹ��
Dbfilename	���񱸷��ļ����ļ���
Dir		���ݿ⾵�񱸷ݵ��ļ�����·��
Slaveof		�������ݿ�Ϊ�������ݿ�Ĵ����ݿ�
Masterauth	�����ݿ�����ʱ��Ҫʹ�õ�����
Requirepass	���õ�¼ʱ��Ҫʹ�õ�����
Maxclients	����ͬʱ���ӵĿͻ�����
Maxmemory	����redis�ܹ�ʹ�õ�����ڴ�
Appendonly	����append onlyģʽ

Appendfsync	���ö�appendonly.aof �ļ�ͬ����Ƶ��
vm-enabled	�Ƿ��������ڴ�֧��
vm-swap-file	���������ڴ�Ľ����ļ�·��
vm-max-memory	����redisʹ�õ���������ڴ��С
vm-page-size	���������ڴ��ҳ��С
vm-pages	���ý����ļ����ܵ�page����
vm-max-threads	����VM ioͬʱʹ�õ��߳�����
Glueoutputbuf	��С�������������һ��
hash-max-zipmap-entries  ����hash���ٽ�ֵ
Activatehashing	����hash

```

# ��������

## �ַ��ͣ�string

```
:6379> set name alex
:6379> set name channel

:6379> setnx name jjjjj

# setnx����key��Ӧ��ֵΪstring���͵�value�����key���ڣ�����0��
# nx����not exist����˼���������򷵻�1

:6379> setex haricolor 10 red
# setex����key��Ӧ��ֵstring���͵�value����ָ����ֵ��Ӧ����Ч��

# setrange

# mset

# get

# getset

# mget

# incr
# decr

# incrby
# decrby

# append

# strlen

```

### hashes ����

redis hash��һ��string���͵�field��value��ӳ���
hash�ر��ʺ��ڴ洢��������ڽ������ÿ���ֶδ�ɵ���string�����͡���һ������洢��hash�����л�ռ�ø��ٵ��ڴ棬���ҿ��Ը�����Ĵ�ȡ��������

```
# hset

# hget

# hmset

# hmget

# hincr
# hincrby

# hexists

# hlen

# hdel

# hkeys

# hvals

# hgetall

```

### lists ����

**lists** ��һ������ṹ����Ҫ������push��pop����ȡһ����Χ������ֵ�ȵȣ�������key���Ϊ��������֡�redis��list������ʵ����һ��ÿ����Ԫ�ض���string���͵�˫���������ǿ���ͨ��push��pop�����������ͷ������β����ӻ�ɾ��Ԫ�أ�����list�ȿ�����Ϊջ���ֿ�����Ϊ���С�

```
# lpush

# lrange

# linsert

# rpush

# lset

# lrange
 
# lrem

# ltrim

# lpop

# rpoplpush

# lindex

```

### sets����

**set**�Ǽ��ϣ�����string���͵����򼯺ϡ�set��ͨ��hash tableʵ�ֵģ����ɾ���Ͳ��ҵĸ��Ӷȶ���0|1���Լ������ǿ���ȡ���������������ͨ����Щ�������ǿ���ʵ��sns�еĺ����Ƽ���blog��tag����

```
# sadd

# smemebers

# srem

# spop

# sdiff

# sdiffstore

# sinter

# sinterstore

# sunion

# sunionstore

# smove

# scard

# sismember

# srandmember

```

### sorted sets����

**sorted set**��set��һ�������汾������set�Ļ�����������һ��˳�����ԣ���һ����������޸�Ԫ�ص�ʱ�����ָ����ÿ��ָ����zset���Զ����°��µ�ֵ����˳�򡣿������Ϊ�����е�mysql��һ�д�value��һ�д�˳�򡣲�����key�������Ϊzset�����֡�

```
# zadd

# zrange

# zrem

# zincrby

# zrank

# zrevrank

# zrangebyscore

# zcount

# zcard

# zremrangebyrank

# zremrangebyscore

```

### redis ���õ�����

redis�ṩ�˷ḻ����������ݿ�͸������ݿ����ͽ��в���
��Щ������linux�ն�ʹ��

```

# ��ֵ���
keys *

del name

expire addr 10

ttl addr

persist

rename

type

ping

echo

select

quit

# �������������

config get dir
config get *

dbsize

flushdb

dbsize

flushdb

```
