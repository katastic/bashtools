#!/bin/sh
ram=$(free -wt | grep Mem: | awk ' { print $8 }')
#echo $ram 
echo $ram | awk -f rambar.awk
