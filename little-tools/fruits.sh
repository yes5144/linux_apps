#!/bin/bash
# 
################################################### 
# Author: erkui
# Blog: http://www.erkui.tech
# Time: 2018-03-10 16:28:19
# Version: V1.0
# Description: This is just a test scripts
################################################### 
# 
Red_Color='\E[1;31m'
Green_Color='\E[1;32m'
Yellow_Color='\E[1;33m'
Blue_Color='\E[1;34m'
Res='\E[0m'

function usage()
{
    echo "Usage: $0 {1|2|3|4|}"
    exit 1
}

function menu()
{
    cat <<END
    1.apple
    2.pear
    3.banana
END
}

function chose()
{
    read -p "Please input your choice:" fruit
    case "$fruit" in
        1)
            echo -e "${Red_Color} apple ${Res}"
            ;;
        2)
            echo -e "${Green_Color} pear ${Res}"
            ;;
        3)
            echo -e "${Yellow_Color} banana ${Res}"
            ;;
        *)
            usage
    esac
}

function main()
{
    menu
    chose
}
main
