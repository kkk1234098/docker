echo "构建master...";
cd mysql-docker-master;
sh run.sh;
cd ../mysql-docker-slave;
echo "构建slave...";
sh run.sh;
cd ../360Atlas;
sh run.sh;
