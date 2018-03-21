#!/bin/bash

JMX_PORT=`expr $1 + 500`

#XX:PermSize需要设置 默认大小会占满perm
JAVA_OPTS="-server -Xms1g -Xmx1g -Xmn256m -XX:PermSize=128m -XX:MaxPermSize=256m \
-Xss256k -XX:+UseParallelGC -XX:+UseParallelOldGC -XX:+UseAdaptiveSizePolicy -XX:MaxGCPauseMillis=100 -XX:ParallelGCThreads=24 \
-XX:+PrintGC -Xloggc:/letv/logs/lepush/gc_$1.log \
-Djava.rmi.server.hostname=$2 \
-Dcom.sun.management.jmxremote \
-Dcom.sun.management.jmxremote.port=$JMX_PORT \
-Dcom.sun.management.jmxremote.authenticate=false \
-Dcom.sun.management.jmxremote.ssl=false"

PHOME="${deploy.base}/${project.name}"

pid=`ps -eo pid,args | grep lepush-online | grep $1 | grep java | grep -v grep | awk '{print $1}'`

if [ -n "$pid" ]
then
    kill -3 ${pid}
    kill ${pid} && sleep 3
    if [  -n "`ps -eo pid | grep $pid`" ]
    then
        kill -9 ${pid}
    fi
    echo "kill pid: ${pid}"
fi

`/letv/apps/jdk/bin/java -DappPort=$1 $JAVA_OPTS -cp $PHOME/conf:$PHOME/lib/* com.letv.test.TestEntrance $1 > /dev/null 2>&1 &`
