#!/bin/bash

HOST=$1
if [[ -z "$1" ]]; then
	HOST=`/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
fi
#开启的端口数
INDEX=0
PARAM=9040

SCRIPT_HOME=$(dirname $(readlink -f $0))
for i in $(seq 0 $INDEX)
do
    PORT=`expr $PARAM + $i`
    bash -ex $SCRIPT_HOME/startup-test.sh $PORT $HOST
done