#!/bin/bash
#
check_url() {
	Http_Code=$(curl -o /dev/null --connect-timeout 3 -s -w "%{http_code}" $1)
	if [ $Http_Code -ne 200 ]; then
		echo "Warning: $1 Access failure!"
	fi
}

#############################3
# another method
check_url_2() {

	# -T timeout  --tries try 1  --spider
	if ! wget -T 10 --tries=1 --spider $1 >/dev/null 2>&1; then
		
		echo "Warning: $1 Access failuser"
	fi
}

# Usages:  check_url www.baidu.com




