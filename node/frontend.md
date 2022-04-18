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

## 4. GetX, ExtendedImage 配置微信返回效果

```dart
ExtendedImageSlidePage
  | Scaffold // 黑色背景
    | ExtendedImageGesturePageView
      | ExtendedImage // 开启 enableSlideOutPage

GetPage(
  opaque: false,
  transition: Transition.noTransition,
  showCupertinoParallax: false,
  ...
)
```

## 5. wechat_assets_picker 使用

### 5.1 压缩图片
1. 卡顿原因: 图片太大, 上传卡主线程. PS: Flutter 中的异步操作并没有开启线程
2. 压缩使用JPEG: PNG格式包含alpha通道, 压缩后体积较大.
3. 不使用isolate的原因: 入参和出参的数据格式只能是基本类型, 限制太大.

```dart
final size = ThumbnailSize((min(Get.width * Get.pixelRatio, entity.size.width)).toInt(),
            (min(Get.height * Get.pixelRatio, entity.size.height).toInt()));
bytes = entity.thumbnailDataWithSize(size, quality: 50, format: ThumbnailFormat.jpeg);
```