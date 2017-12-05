#!/bin/bash

# description

# 1, top ip

awk {print $1} erkui_access.log | sort | uniq -c | sort -rn | head

# 2, top web
awk {print $7} erkui_access.log | sort |uniq -c| sort -rn |head

# 3, count 50x

