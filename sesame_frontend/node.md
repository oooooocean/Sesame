# 工程
## 1. 创建工程

```shell
flutter create -i swift -a kotlin --platforms ios,android,web --org com.sesame  sesame_frontend
```

## 2. JSON 解析
```shell
flutter packages pub run build_runner watch --delete-conflicting-outputs
```

# Code
## 1. 按钮居左

```text
ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero), alignment: Alignment.centerLeft)
```

## 2. 按钮配置

```text
ButtonStyle(
          overlayColor: MaterialStateProperty.all(accentColor), # 配合 Opacity 设置点击颜色
          elevation: MaterialStateProperty.all(5),
          fixedSize: MaterialStateProperty.all(Size.fromHeight(coverHeight)), # 配合padding
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))))
          );
```

## 3. nullable 强转

```dart
final validFiles = files.where((element) => element != null).map((e) => e!).toList();
```