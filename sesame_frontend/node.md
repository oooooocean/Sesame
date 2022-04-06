# 工程
## 1. 创建工程

```shell
flutter create -i swift -a kotlin --platforms ios,android,web --org com.sesame  sesame_frontend
```

# Code
## 1. 按钮居左

```text
ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero), alignment: Alignment.centerLeft)
```