# this is redis

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

