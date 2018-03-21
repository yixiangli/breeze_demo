#!/bin/bash
name="${project.name}"
deploy="${deploy.base}"
webapp="${deploy}/${project.name}"
servers=(${deploy.online.server})
SCRIPT_HOME="${deploy}/${project.name}/deploy"

serverCount=${#servers[@]}
serial_no=`date +%s`
i=0
while [ $i -lt $serverCount ]
do
    server=${servers[$i]}
    echo "deploy $name on $server"
    host=`echo $server`

    ssh root@$host "$shell stop" || echo "$shell is not running"

    if [ ! -s $deploy/$name-$serial_no.tar ] ; then
        ssh root@$host "mkdir -p $webapp"

        scp artifacts/$name.tar.gz root@$host:$deploy
        ssh root@$host "rm -rf $webapp/*"
		ssh root@$host "cd ${deploy} && tar -zxv -f $deploy/$name.tar.gz"
		ssh root@$host "mv $webapp/conf/deploy $webapp/"
		ssh root@$host "mkdir -p $deploy/bak"
        ssh root@$host "cp $deploy/$name.tar.gz $deploy/$name-$serial_no.tar.gz &&  mv $deploy/$name-$serial_no.tar.gz $deploy/bak/"
    fi

    ssh root@$host "bash -ex $SCRIPT_HOME/run-test.sh $server"
    sleep 10
    i=$((i+1))
done
echo "all done."
