FROM centos:centos7
COPY Atlas-2.2.1.el6.x86_64.rpm /Atlas.rpm
COPY atlas.cnf /test.cnf
#COPY atlas.cnf /usr/local/mysql-proxy/conf/atlas.cnf
COPY conf.sh /conf.sh
COPY runs /runs
#设置时区
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
CMD ["bash", "/conf.sh"]
