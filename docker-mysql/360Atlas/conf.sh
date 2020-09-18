#!/bin/bash
set -e
read a < /runs
if [ $a == '1' ]
then
	rpm -ivh /Atlas.rpm
	echo "替换atlas配置文件..."
	echo y|cp /test.cnf /usr/local/mysql-proxy/conf/test.cnf
	rm -f /test.cnf
fi	


pwd=`/usr/local/mysql-proxy/bin/encrypt $ATLAS_PASS`
sed -i 's/ATLASPASS/'$pwd'/' /usr/local/mysql-proxy/conf/test.cnf
sed -i 's/ATLASUSER/'$ATLAS_USER'/' /usr/local/mysql-proxy/conf/test.cnf
sed -i 's/MASTERCONFIG/'$MASTER_CONFIG'/' /usr/local/mysql-proxy/conf/test.cnf
sed -i 's/SLAVECONFIG/'$SLAVE_CONFIG'/' /usr/local/mysql-proxy/conf/test.cnf

a=$[$a+1]
#echo $a
echo $a > /runs

cd /usr/local/mysql-proxy/bin
echo "启动服务..."
./mysql-proxyd test start
tail -f /dev/null
