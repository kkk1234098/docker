# mysql主从+atlas中间件
安装步骤\
1、/mysql-docker-**/mysqld.cnf设置mysql基础配置，主从都要设置\
2、/360Atlas/atlas.cnf配置\
3、docker-compose.yml配置\
4、sh install 安装启动\
---
sh unstall 卸载
部分配置抽离在yml中，可以重新自定义