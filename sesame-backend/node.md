# 项目配置
## 1. windows 使用 venv
[引用](https://packaging.python.org/en/latest/guides/installing-using-pip-and-virtual-environments/#creating-a-virtual-environment)
```shell
# 构建环境 venv
> py -m venv venv

# 激活环境
# 报错的话执行: Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
> .\venv\Scripts\activate
```

## 2. windows 安装 mysql

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