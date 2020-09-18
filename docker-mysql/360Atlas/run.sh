echo "构建atlas中间件...";
docker build -t hc/atlas:2.2 .;
#docker run -itd  -p 3000:1234  --name hc-atlas hc/atlas:2.2;
#echo "运行atlas中间件...";
#docker run -itd -v /www/server/docker-mysql/360Atlas/conf/:/usr/local/mysql-proxy/conf/ -p 3000:1234  --name hc-atlas hc/atlas:2.2;
echo "构件完成...";
