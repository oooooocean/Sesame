# 项目配置
## 0. 生产环境上线check list
- 检查api文档是否需要更新
- 检查数据库版本是否需要升级: 升级到目标版本
- 检查当前python执行环境: 切换到venv
- supervisorctl 重启服务

## 1. venv
### 1.1 windows
[引用](https://packaging.python.org/en/latest/guides/installing-using-pip-and-virtual-environments/#creating-a-virtual-environment)
```shell
# 构建环境 venv
> py -m venv venv

# 激活环境
# 报错的话执行: Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
> .\venv\Scripts\activate
```

### 1.2 linux
[参考](https://blog.csdn.net/weixin_40903525/article/details/122299094)
```shell
source ./venv/bin/activate
```

### 1.3 更新python到3.10
1. 重新执行 `python -m venv venv`
2. 重新设置执行环境的python解释器版本

## 2. [Windows] 安装 mysql

```shell
# 配置环境变量
mysql/bin

# 安装 mysqld 服务
> mysqld --install

# 初始化 root 账户
# 如果忘记临时密码, 就删除 mysql 下的 data 目录
> mysqld --initialize --user=root --console

# 启动服务
> net start mysql

# 登录mysql
> mysql -u root -p

# 更改账户密码
mysql> alert user user() identified by "自定义的密码"

# 创建数据库
CREATE DATABASE IF NOT EXISTS puppy DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_general_ci;
```

## 3. requirements 保存依赖包

```shell
# 生成 requirements
> pip freeze > ./requirements.txt

# 安装
# 安装前激活 venv
> pip install -r ./requirements.txt
# 或
> pip3 install -r ./requirements.txt -i http://pypi.douban.com/simple --trusted-host pypi.douban.com
```

## 4. [MAC] 解决 mysql_config not found 和 NameError: name '_mysql' is not defined
[引用](https://www.cnblogs.com/shellshell/p/7106426.html)
[引用2](https://stackoverflow.com/questions/63109987/nameerror-name-mysql-is-not-defined-after-setting-change-to-mysql)

```shell
# mysql_config not found
> ln -s /usr/local/mysql/bin/mysql_config /usr/local/bin/mysql_config

# NameError: name '_mysql' is not defined
# 编辑配置
> vi ~/.bash_profile

# 添加
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib/

# 刷新配置
> source ~/.bash_profile

# 运行项目 NameError: name '_mysql' is not defined
# Mysqldb 不兼容 python3.5 以后的版本
> pip install pymysql
import pymysql
pymysql.install_as_MySQLdb()
```

## 5. Mysql
### 5.1 [CenterOS] 安装 
[参考](https://blog.csdn.net/weixin_44244088/article/details/122286105)
[mysql_config报错参考](https://blog.csdn.net/hknaruto/article/details/82852308)

### 5.2 操作
- 清空数据库

```sql
# 删除外键约束
SET foreign_key_checks = 0;
# 生成截断语句
select CONCAT('TRUNCATE TABLE ',table_name,';') from information_schema.tables where TABLE_SCHEMA = 'sesame';
# 启动外键约束
SET foreign_key_checks = 1;
```

- 重启

```shell
# liunx
service mysqld restart
```

### 5.3 修改字符集

```shell
# 查找配置文件可能的位置
$ mysql --help --verbose | grep my.cnf

# 如果配置文件不存在
$ sudo touch /etc/my.cnf
$ sudo chmod 664 /etc/my.cnf
$ sudo vim /etc/my.cnf
# 添加如下内容
[client]
default-character-set = utf8mb4

[mysql]
default-character-set = utf8mb4

[mysqld]
character-set-client-handshake = FALSE
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci
init_connect='SET NAMES utf8mb4'

# 检查变量是否修改成功
mysql > SHOW VARIABLES WHERE Variable_name LIKE 'character_set_%' OR Variable_name LIKE 'collation%';

# 修改数据库编码
mysql > ALTER DATABASE sesame CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

# 修改表编码
mysql > ALTER TABLE user_info CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci; 
```

## 6. [CenterOS] 安装Python3
[参考](https://blog.csdn.net/qq_36750158/article/details/80609857)
[ssl报错, 更新ssl版本](https://blog.csdn.net/weixin_32110907/article/details/116884575)
[ssl报错, 重新编译python](https://blog.csdn.net/qq_23889009/article/details/100887640)
```shell
cd Python-3.10
./configure -C --with-openssl=/usr/local/openssl --with-openssl-rpath=auto
```

## 7. 文件同步到服务器
### 7.1 [Git] 拉取指定文件夹

```shell
$ git init    //git初始化
$ git remote add -f origin http://githhub/projectName.git
$ git config core.sparsecheckout true
$ echo "sesame-backend" >> .git/info/sparse-checkout
$ cat .git/info/sparse-checkout
$ git pull origin master
```

### 7.2 SCP
[Secure copy](https://blog.csdn.net/qq_36078992/article/details/105847132)

```shell
# 拷贝并覆盖文件夹的内容
# /web, 仅拷贝文件夹, 如果存在不会覆盖
scp -r sesame_www/build/web/. root@39.107.136.94:/projects/sesame_www
```

## 8. [nginx] 配置
[nginx启动、重启、关闭](https://blog.csdn.net/hyy147/article/details/119734841)

### 8.1 操作
```shell
# 查找配置文件
$ ps aux|grep nginx
# cd 到查找到的目录 xxx/nginx/sbin
# 启动
$ ./nginx
# 修改配置
# nginx/conf/nginx.conf
# 判断配置是否正确
$ ./nginx -t
# 重启
$ ./nginx -s reload
```

### 8.2 报错
```shell
# bind() to 0.0.0.0:80 failed (98: Address already in use)
# 80端口被占用
# fuser 命令可以干掉绝大数占用端口的程序或文件
fuser -k 80/tcp 
# 或
sudo fuser -k 80/tcp
```

### 8.3 卸载
[参考](https://blog.csdn.net/qq_39505065/article/details/106765950)

### 8.4 缓存
1. location 中添加 `add_header Cache-Control "no-cache, no-store";`
2. 编译产物中的资源文件添加 query

```text
scriptTag.src = 'main.dart.js?v=1';
// 或
scriptTag.src = 'main.dart.js?1;
```

### 8.5 配置

```text
# 路径重写
location /api/ {
  rewrite ^/api/(.*) /$1 break;
  proxy_pass http://forontends;
}
```

## 9. [Supervisor] 配置
[参考](https://blog.csdn.net/yzlaitouzi/article/details/108531326)
[报错 Exited too quickly (process log may have details)](https://blog.csdn.net/nbcsdn/article/details/108660702)

### 9.1 venv 报错

```text
[group:sesames]
programs=sesame-0,sesame-1

[program:sesame-0]
# 重点: 执行环境设置为venv
command=/projects/sesame/sesame-backend/venv/bin/python3 /projects/sesame/sesame-backend/main.py --port=8000
directory=/projects/sesame/sesame-backend/
...
```

## 10. ssh
### 10.1 登录后台

```shell
# 登录
$ ssh root@ip

# 登出
$ logout
```

# 技术点
## 1. 正则匹配
- `\w` 即 `[a-zA-Z0-9_]`
- 汉字 `[\u4e00-\u9fa5]`