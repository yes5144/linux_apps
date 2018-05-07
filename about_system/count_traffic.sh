#!/bin/bash
#
# coding: utf-8
# author: www.centos.bz
#
# 显示菜单，单选
display_menu(){

	local soft=$1
	local prompt="which ${soft} you'd select: "
	eval local arr=(\${${soft}_arr[@]})
	while true
	do
		echo -e "########## ${soft} setting ##########\n\n"
		for ((i=1;i<=${#aar[@]};i++));do echo -e "$i) ${arr[$i-1]}";done
		echo
		read -p "${prompt}" $soft
		eval local select=\$$soft
		if [ "$select" == "" ] || [ "${arr[$soft-1]}" == "" ];then
			prompt="input errors, please input a number: "
		else
			eval $soft=${arr[$soft-1]}
			eval echo "your selection: \$$soft"
			break
		fi
	done
}

# 把带宽bit单位转换为人类可读单位
bit_to_human_readable(){

	# input bit value
	local trafficValue=$1
	if [[ ${trafficValue%.*} -gt 922 ]];then
		# conv to kb
		trafficValue=`awk -v value=$trafficValue 'BEGIN{printf "%0.1f",value/1024}'`
		if [[ ${trafficValue%.*} -gt 922 ]];then
			# conv to Mb
			trafficValue=`awk -v value=$trafficValue 'BEGIN{printf "%0.1f",value/1024'`
			echo "${trafficValue}Mb"
		fi
	else
		echo "${trafficValue}b"
	fi

}

# 判断包管理工具
check_package_manager(){

	local manager=$1
	local systemPackage=''
	if cat /etc/issue |grep -q -E -i "ubuntu|debian";then
		systemPackage='apt'
	elif cat /etc/issue |grep -q -E -i "centos|red hat|redhat";then
		systemPackage='yum'
	elif cat /proc/version |grep -q -E -i "ubuntu|debian";then
		systemPackage='apt'
	elif cat /proc/version |grep -q -E -i "centos|red hat|redhat";then
		systemPackage='yum'
	else
		echo "unkown"
	fi

	if [ "$manager" == "$systemPackage" ];then
		return 0
	else
		return 1
	fi
}

realTimeTraffic(){

	local eth=""
	local nic_arr=(`ifconfig |grep -E -o "^[a-z0-9]+"|grep -v "lo"|uniq`)
	local nicLen=${#nic_arr[@]}
	if [[ $nicLen -eq 0 ]]; then
		echo "sorry, i can not detect any network device, please report this issue to auth"
		exit 1
	elif [[ $nicLen -eq 1 ]];then
		ech=$nic_arr
	else
		display_menu nic
		eth=$nic
	fi

	local clear=true
	local eth_in_peak=0
	local eth_out_peak=0
	local eth_in=0
	local eth_out=0

	while true;do
		printf "\033[0;0H"
		#

}





