#!/bin/bash

set -e

echo '1. set server_id....'
#sed -i '/\[mysqld\]/a server-id=1\nlog-bin=/var/log/mysql/mysql-bin\ngtid-mode=ON\nenforce-gtid-consistency=ON'  /etc/mysql/mysql.conf.d/mysqld.cnf


echo '2. start mysql-master...'
sed -i 's/SERVERID/'$SERVER_ID'/' /etc/mysql/mysql.conf.d/mysqld.cnf
service mysql start

read a < /mysql/runs
if [ $a == '1' ]
then
   echo '3. setting password...'
   sed -i 's/MYSQLROOTPASSWORD/'$MYSQL_ROOT_PASSWORD'/' /mysql/privileges.sql
   sed -i 's/MYSQLREPLICATIONUSER/'$MYSQL_REPLICATION_USER'/' /mysql/privileges.sql
   sed -i 's/MYSQLREPLICATIONPASSWORD/'$MYSQL_REPLICATION_PASSWORD'/' /mysql/privileges.sql
   mysql < /mysql/privileges.sql
else
   echo '3. start master...'
fi

a=$[$a+1]
#echo $a
echo $a > /mysql/runs

echo '4. service mysql status'
echo 'mysql for hc-mysql-master if ready...'

tail -f /dev/null
