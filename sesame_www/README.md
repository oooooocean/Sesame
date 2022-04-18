## 1. 工程
### 1.1 创建工程

```shell
flutter create --platforms web sesame_www
```

### 1.2 打包和部署

```shell
flutter build web --release
```

## 2. 自定义 ScrollBehavior 以支持鼠标刷滑动


```dart
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices =>
      {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse
      };
}
```