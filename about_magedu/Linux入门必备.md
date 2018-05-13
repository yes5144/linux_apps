## 描述计算机的组成及其功能

主要分为五个部分:

1. 控制器(Control):是整个计算机的中枢神经，其功能是对程序规定的控制信息进行解释，根据其要求进行控制，调度程序、数据、地址，协调计算机各部分工作及内存与外设的访问等。

2. 运算器(Datapath):运算器的功能是对数据进行各种算术运算和逻辑运算，即对数据进行加工处理。

3. 存储器(Memory):存储器的功能是存储程序、数据和各种信号、命令等信息，并在需要时提供这些信息。

4. 输入(Input system):输入设备是计算机的重要组成部分，输入设备与输出设备合称为外部设备，简称外设，输入设备的作用是将程序、原始数据、文字、字符、控制命令或现场采集的数据等信息输入到计算机。常见的输入设备有键盘、鼠标器、光电输入机、磁带机、磁盘机、光盘机等。

5. 输出(Output system):输出设备与输入设备同样是计算机的重要组成部分，它把外算机的中间结果或最后结果、机内的各种数据符号及文字或各种控制信号等信息输出出来。微机常用的输出设备有显示终端CRT、打印机、激光印字机、绘图仪及磁带、光盘机等。

(cpu=控制器+运算器
主板=I/O总线，输入输出系统
存储器=内存+硬盘
I/O设备:键盘,鼠标，扫描仪，显示器等等）


## 按系统罗列Linux的发行版，并描述不同发行版之间的联系

[最受欢迎的Linux版本](https://www.cnblogs.com/telwanggs/p/7435641.html)

|Linux版本|包管理器|前端|
|--|--|--|
|Redhat|rpm|yum|
|CentOS|rpm|yum|
|Ubuntu|dpkg|apt-get|
|Debian|dpkg|apt-get|
|Kali|渗透||
|Suse|||
|Gentoo|||


## 描述Linux的哲学思想，并按照自己的理解对其进行解释性描述

Linux哲学思想：

- 一切皆文件；
- 小型，单一用途的程序；
- 连接程序，共同完成复杂功能；
- 避免令人困惑的用户界面；
- 配置数据存储在文本中；

解释：
一切皆文件：是 Unix/Linux 的基本哲学之一。不仅普通的文件，目录、字符设备、块设备、 套接字等在 Unix/Linux 中都是以文件被对待；它们虽然类型不同，但是对其提供的却是同一套操作界面。

小型，单一用途的程序：程序和可执行文件不要太复杂，这样才能保证了linux内核的高效运行

连接程序，共同完成复杂功能：复杂的任务可以通过连接多个简单的程序实现复杂的功能。对于复杂的功能linux通过许多简单程序的组合等方式实现，在保证简单功能的高效性的同时，复杂的程序也必然是高效性的

避免令人困惑的用户界面：如windows那样出了问题一般人选择的会是重启，实在是不行的话就是 重新 安装系统了，因为对于windows那样不是开源的，并且用户界面比较 复杂操作系统出了问题，一般的人是根本没有办法解决的。但是linux就不一样了，第一linux是开源的，无论什么问题都可以通过简洁的命令行实现 排错，修改系统的配置，一切都是简洁明了为基础。

配置数据存储在文本中：linux所有的配置文件都存放在文本配置文件当中，无论什么配置修改都只需修改其配置文件即可，配置文件时文本形式的只需任意一款文本编辑器修改即可而不是类似于windows那样将保存在注册表中，并且windows的注册表需要专门的二进制或十六进制的编辑器才可编辑，修改比较复杂

## 说明Linux系统上命令的使用格式；详细介绍ifconfig, echo, tty, startx, export, pwd, history, shutdown, poweroff, reboot, hwclock, date命令的使用，并配合相应的示例来阐述。

命令的使用格式：command -options file

命令帮助文档的使用：man command

#### ifconfig
#### echo
#### tty
#### startx
#### export
#### pwd
#### history
#### shutdown
#### poweroff
#### reboot
#### hwclock
#### date


## 如何在Linux系统上获取命令的帮助信息，请详细列出，并描述man文档的章节是如何划分的。

man command

command --help

Linux的man很强大，该手册分成很多section，使用man时可以指定不同的section来浏览，各个section意义如下： 
>1 - commands
2 - system calls
3 - library calls
4 - special files
5 - file formats and convertions
6 - games for linux
7 - macro packages and conventions
8 - system management commands
9 - 其他

解释一下, 
    1是普通的命令
    2是系统调用,如open,write之类的(通过这个，至少可以很方便的查到调用这个函数，需要加什么头文件)
    3是库函数,如printf,fread
    4是特殊文件,也就是/dev下的各种设备文件
    5是指文件的格式,比如passwd, 就会说明这个文件中各个字段的含义
    6是给游戏留的,由各个游戏自己定义
    7是附件还有一些变量,比如向environ这种全局变量在这里就有说明
    8是系统管理用的命令,这些命令只能由root使用,如ifconfig
    想要指定section就直接在man的后面加上数字,比如 :
    man 1 ls
    man 3 printf
等等
对于像open,kill这种既有命令,又有系统调用的来说,man open则显示的是open(1),也就是从最前面的section开始,如果想查看open系统调用的话,就得man 2 open

## 罗列Linux发行版的基础目录名称命名法则及功用规定。

    /bin 二进制可执行命令
    /dev 设备特殊文件
    /etc 系统管理和配置文件
    /etc/rc.d 启动的配置文件和脚本
    /home 用户主目录的基点，比如用户user的主目录就是/home/user，可以用~user表示
    /lib 标准程序设计库，又叫动态链接共享库，作用类似windows里的.dll文件
    /sbin 超级管理命令，这里存放的是系统管理员使用的管理程序
    /tmp 公共的临时文件存储点
    /root 系统管理员的主目录
    /mnt 系统提供这个目录是让用户临时挂载其他的文件系统
    /lost+found这个目录平时是空的，系统非正常关机而留下“无家可归”的文件（windows下叫什么.chk）就在这里
    /proc 虚拟的目录，是系统内存的映射。可直接访问这个目录来获取系统信息。
    /var 某些大文件的溢出区，比方说各种服务的日志文件
    /usr 最庞大的目录，要用到的应用程序和文件几乎都在这个目录，其中包含：

    /usr/x11R6 存放x window的目录
    /usr/bin 众多的应用程序
    /usr/sbin 超级用户的一些管理程序
    /usr/doc linux文档
    /usr/include linux下开发和编译应用程序所需要的头文件
    /usr/lib 常用的动态链接库和软件包的配置文件
    /usr/man 帮助文档
    /usr/src 源代码，linux内核的源代码就放在/usr/src/linux里
    /usr/local/bin 本地增加的命令
    /usr/local/lib 本地增加的库根文件系统
