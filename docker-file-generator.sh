#!/bin/sh
#var
#生成Dockerfile

echo "开始执行脚本"

index=1
envs[0]="DEV"
envs[1]="PRO"
env_tips="可选的环境:"

for item in ${envs[@]};
do
	env_tips+="$index:$item  "
	let index++
done

echo "$env_tips"
read -t 30 -p "请输入环境的索引:" env_index

# 设置环境
environment=${envs[env_index-1]}

# 设置集群
read -t 30 -p "请输入集群(skip for default):" cluster_name
if [ "$cluster_name" == "" ]
then
	cluster_name="default"
fi

# 设置jar文件名
read -t 30 -p "请输入jar包文件名(xxx.jar):" jar_file_name

# 设置镜像名
read -t 30 -p "请输入镜像名:" image_name

# 确认信息
echo -e "======================"
echo -e "环境:\t\t$environment"
echo -e "集群:\t\t$cluster_name"
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
ADD $jar_file_name app.jar 
# 设置时区
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
# 运行jar包
RUN bash -c 'touch /app.jar'
ENTRYPOINT ["java","-Denv=$environment","-Dapollo.cluster=$cluster_name","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
EOF
echo "Dockerfile已生成"
# 构建镜像

docker build -t $image_name .

# "现在时间：`date '+%Y%m%d %H:%M:%S'`"
