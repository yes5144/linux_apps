# ansible ����ģ��

����ģ�鹦�ܷ���Ϊ����ģ�顢����ģ�顢���ݿ�ģ�顢�ļ�ģ�顢�ʲ�ģ�顢��Ϣģ�顢���ģ�顢����ģ�顢֪ͨģ�顢������ģ�顢Դ�����ģ�顢ϵͳģ�顢��Ԫģ�顢web��ʩģ�顢Windowsģ�顣

## ��װansible

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


�����������һЩ��õ�ģ�飻

### �ռ��ͻ�������Ϣ
```
ansible all -m setup
```

### ping ģ��

```
ansible all -m ping

```
### ִ������

```
ansible -i /etc/ansible/hosts test -u root -m command -a 'ls -l /root/' -k

# ������
ansible test -a 'ls -l /root/' -k

```

### file ģ��

```
ansible test -m file -a "src=/etc/fstab dest=/tmp/fstab state=link"

ansible test -m file -a "path=/tmp/fstab state=absent"

ansible test -m file -a "path=/tmp/test state=touch"

ansible test -m file -a "path=/tmp/d2 state=directory owner=root group=root mode=700"

ansible test -m command -a "ls /tmp -lh"

```
