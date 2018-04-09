# ansible 常用模块

根据模块功能分类为：云模块、命令模块、数据库模块、文件模块、资产模块、消息模块、监控模块、网络模块、通知模块、包管理模块、源码控制模块、系统模块、单元模块、web设施模块、Windows模块。

## 安装ansible

```
yum install ansible -y

rpm -ql ansible

/etc/ansible
/etc/ansible/ansible.cfg
/etc/ansible/hosts
/etc/ansible/roles
...

ansible -h

ansible --version

```
```
cat >/etc/ansible/hosts << EOF

[test]
192.168.0.211

# children
[mfs:children]
mfs_master
mfs_client
mfs_node

[mfs_master]
192.168.204.11

[mfs_client]
192.168.204.21

[mfs_node]
192.168.204.31

EOF

```


这里仅仅介绍一些最常用的模块；

### 收集客户机的信息
```
ansible all -m setup
```

### ping 模块

```
ansible all -m ping

```
### 执行命令

```
ansible -i /etc/ansible/hosts test -u root -m command -a 'ls -l /root/' -k

# 简化如下
ansible test -a 'ls -l /root/' -k

```

### file 模块

```
ansible test -m file -a "src=/etc/fstab dest=/tmp/fstab state=link"

ansible test -m file -a "path=/tmp/fstab state=absent"

ansible test -m file -a "path=/tmp/test state=touch"

ansible test -m file -a "path=/tmp/d2 state=directory owner=root group=root mode=700"

ansible test -m command -a "ls /tmp -lh"

```
