删除文件 text中第一列

 方式一
```
awk '{$1="";print $0}' text
```

方式二
```
sed -e 's/[^ ]* //' text
```
