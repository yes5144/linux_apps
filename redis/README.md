# this is redis

**redis** 是一个key-value存储系统，与memcached类似，但是解决了断电后数据完全丢失的现象。支持数据类型有string，lists，sets，zsets。这些数据类型都支持push/pop，add/remove以及取交集、并集、差集等操作，对这些操作都是原子性的，redis还支持各种不同的排序能力。

## 下载和安装

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

安全性
主从复制
事务处理
持久化机制
发布订阅消息
虚拟内存的使用

### 安全性，账号和密码

设置客户端连接后进行任何操作，需要输入密码

警告：因为redis是内存型数据库，外部用户可以150K/s的密码尝试

```
vim /usr/local/redis/etc/redis.conf

# 找到 requirepass

# 指定配置文件启动
/usr/local/redis/bin/redis-server /usr/local/redis/etc/redis.conf

# 进入redis客户端
redis-cli

# 密码认证登录
/usr/local/redis/bin/redis-cli -a password

127.0.0.1:6370> auth password

```


### redis.conf 说明

```
daemonize	如果需要在后台运行，把该项改为yes
pidfile 	配置多个pid的地址，默认在/var/run/redis.pid
bind		绑定ip，设置后只接受来自该ip的请求
port		监听端口，默认为6379
timeout		设置客户端连接时的超时时间，单位是秒
loglevel	分为4级debug,verbose,notice, warning
logfile		配置log文件地址
database	设置数据库的个数，默认使用的数据库为0
save		设置redis进行数据库镜像的频率

rdbcompression	在进行镜像备份时，是否进行压缩
Dbfilename	镜像备份文件的文件名
Dir		数据库镜像备份的文件放置路径
Slaveof		设置数据库为其他数据库的从数据库
Masterauth	主数据库连接时需要使用的密码
Requirepass	设置登录时需要使用的密码
Maxclients	限制同时连接的客户数量
Maxmemory	设置redis能够使用的最大内存
Appendonly	开启append only模式

Appendfsync	设置对appendonly.aof 文件同步的频率
vm-enabled	是否开启虚拟内存支持
vm-swap-file	设置虚拟内存的交换文件路径
vm-max-memory	设置redis使用的最大物理内存大小
vm-page-size	设置虚拟内存的页大小
vm-pages	设置交换文件的总的page数量
vm-max-threads	设置VM io同时使用的线程数量
Glueoutputbuf	把小的输出缓存存放在一起
hash-max-zipmap-entries  设置hash的临界值
Activatehashing	重新hash

```

# 数据类型

## 字符型：string

```
:6379> set name alex
:6379> set name channel

:6379> setnx name jjjjj

# setnx设置key对应的值为string类型的value，如果key存在，返回0；
# nx就是not exist的意思，不存在则返回1

:6379> setex haricolor 10 red
# setex设置key对应的值string类型的value，并指定键值对应的有效期

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

### hashes 类型

redis hash是一个string类型的field和value的映射表。
hash特别适合于存储对象。相较于将对象的每个字段存成单个string的类型。将一个对象存储在hash类型中会占用更少的内存，并且可以更方便的存取整个对象。

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

### lists 类型

**lists** 是一个链表结构，主要功能是push、pop，获取一个范围的所有值等等，操作中key理解为链表的名字。redis的list类型其实就是一个每个子元素都是string类型的双向链表。我们可以通过push、pop操作从链表的头部或者尾部添加或删除元素，这样list既可以作为栈，又可以作为队列。

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

### sets类型

**set**是集合，它是string类型的无序集合。set是通过hash table实现的，添加删除和查找的复杂度都是0|1。对集合我们可以取并集、交集、差集。通过这些操作我们可以实现sns中的好友推荐和blog的tag功能

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

### sorted sets类型

**sorted set**是set的一个升级版本，它是set的基础上增加了一个顺序属性，这一属性在添加修改元素的时候可以指定，每次指定后，zset会自动重新按新的值调整顺序。可以理解为有两列的mysql表，一列存value，一列存顺序。操作中key可以理解为zset的名字。

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

### redis 常用的命令

redis提供了丰富的命令对数据库和各种数据库类型进行操作
这些命令在linux终端使用

```

# 键值相关
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

# 服务器相关命令

config get dir
config get *

dbsize

flushdb

dbsize

flushdb

```
