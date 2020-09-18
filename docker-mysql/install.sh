sh build.sh;

docker-compose up -d  mysql-master;

sleep 3;

docker-compose up -d  mysql-slave;

sleep 3;

docker-compose up -d  mysql-slave2;

sleep 3;

docker-compose up -d atlas;
