# 项目配置
## 1. [Windows] 使用 venv
[引用](https://packaging.python.org/en/latest/guides/installing-using-pip-and-virtual-environments/#creating-a-virtual-environment)
```shell
# 构建环境 venv
> py -m venv venv

# 激活环境
# 报错的话执行: Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
> .\venv\Scripts\activate
```

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

## 5. [CenterOS] 安装 Mysql
[参考](https://blog.csdn.net/weixin_44244088/article/details/122286105)
[mysql_config报错参考](https://blog.csdn.net/hknaruto/article/details/82852308)

## 6. [CenterOS] 安装Python3
[参考](https://blog.csdn.net/qq_36750158/article/details/80609857)

## 7. [Git] 拉取指定文件夹

```shell
$ git init    //git初始化
$ git remote add -f origin http://githhub/projectName.git
$ git config core.sparsecheckout true
$ echo "sesame-backend" >> .git/info/sparse-checkout
$ cat .git/info/sparse-checkout
$ git pull origin master
```

## 8. [nginx] 配置
[nginx启动、重启、关闭](https://blog.csdn.net/hyy147/article/details/119734841)
```shell
# 查找配置文件
$ ps aux|grep nginx
# cd 到查找到的目录
# 启动
$ ./nginx
# 修改配置
# nginx/conf/nginx.conf
# 判断配置是否正确
$ ./nginx -t
# 重启
$ ./nginx -s reload
```

# 技术点
## 1. 正则匹配
- `\w` 即 `[a-zA-Z0-9_]`
- 汉字 `[\u4e00-\u9fa5]`

## 2. SQLAlchemy

```python
# 1. info 可能为 None 的处理
user_json['info'] = user.info.to_json() if user.info else None
```

## 3. enum.Enum
define unique sets of names and values. 
- property
    -  `name`
    -  `value`
-  support iteration
-  hashable
-  if the exact value is unimportant you can use auto.
-  `__members__`: mapping of names to members.
-  members are compared by identity.

```python
# IntFlag: Int
# can be combined using the bitwise operators without losing their IntFlag membership.

# Create
from enum import Enum
class Color(Enum):
    RED = 1  
    GREEN = 2
Color(1)  # Red
Color['Red'] # Red
Color.Red.name # 'Red'
Color.Red.value # 1  

# Iteration
list(Color)
for name, member in Color.__members__.items():

# Comparisons
Color.RED is Color.RED
```

## 4. dict KeyError 解决

```python
m_dict = {}

if 'key' in m_dict:
    pass

# or

m_dict.get('key', default=None)
```

## 5. override

```python
def to_json(self) -> dict:
    json = ModelMixin.to_json(self)
```