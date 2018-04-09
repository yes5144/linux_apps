# this is redis

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

