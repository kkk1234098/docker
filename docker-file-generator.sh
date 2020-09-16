#!/bin/sh
#var

# 生成Dockerfile
createDockerfile() {
cat>./Dockerfile<<EOF
# Docker image for springboot file run
# VERSION 0.0.1
# Author: Parkson IT
# 基础镜像使用java
FROM java:8
# 作者
MAINTAINER Parkson IT
# VOLUME 指定了临时文件目录为/tmp。
# 其效果是在主机 /var/lib/docker 目录下创建了一个临时文件，并链接到容器的/tmp
#VOLUME /tmp 
# 将jar包添加到容器中并更名为app.jar
ADD $1 app.jar 
# 设置时区
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
# 运行jar包
RUN bash -c 'touch /app.jar'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
EOF
}


# 脚本开始
echo "开始执行脚本"

# 设置jar文件名
read -t 30 -p "请输入jar包文件名:" jar_file_name
# 判断后缀是否为jar
if [ "${jar_file_name##*.}"x != "jar"x ]
then
    # 补上.jar
    jar_file_name=${jar_file_name}.jar
fi

# 设置镜像名
read -t 30 -p "请输入IMAGE名字（跳过则使用jar的包名）:" image_name
if [ "$image_name" == "" ]
then
	image_name=${jar_file_name%%.*}
fi

# 确认信息
echo -e "======================"
echo -e "jar包名:\t$jar_file_name"
echo -e "镜像名:\t\t$image_name"
echo -e "======================"
read -t 30 -p "请确认以上信息(y/n):" confirm
#如果$a等于a*(字符匹配),那么结果为true
if [ "$confirm" != "y" ]
then
	echo "退出"
	exit 1 
fi

if [ ! -f "$jar_file_name" ]
then
	echo -e "$jar_file_name 不存在"
	echo "退出"
	exit 1 
fi

# 生成Dockerfile
createDockerfile $jar_file_name
echo "Dockerfile已生成"
# 构建镜像

echo "开始构建IMAGE..."
docker build -t $image_name .
echo "IMAGE构建完成"
# "现在时间：`date '+%Y%m%d %H:%M:%S'`"

echo "准备创建容器..."
docker-compose config
if [ $? -ne 0 ]
then
	exit 1
fi

read -t 30 -p "请确认以上配置(y/n):" confirm
if [ "$confirm" != "y" ]
then
	echo "退出"
	exit 1 
fi

docker-compose up -d
