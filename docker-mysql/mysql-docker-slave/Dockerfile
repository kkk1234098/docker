FROM mysql:5.7
MAINTAINER hc

ENV MYSQL_ALLOW_EMPTY_PASSWORD yes
COPY mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
COPY conf.sh /mysql/conf.sh
COPY privileges.sql /mysql/privileges.sql
COPY restart.sql /mysql/restart.sql
COPY runs /mysql/runs
#设置时区
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
CMD ["bash", "/mysql/conf.sh"]
