import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sesame_www/components/theme_mixin.dart';
import 'package:sesame_www/pages/home/home_page_controller.dart';

class HomePage extends GetView<HomePageController> with ThemeMixin {

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar,
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.only(top: Get.statusBarHeight + kToolbarHeight),
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('/bg.jpeg'), fit: BoxFit.cover)),
        child: DefaultTextStyle(style: const TextStyle(color: Colors.white), child: _body),
      ),
    );
  }

  AppBar get _appBar {
    final actions = isSmallScreen
        ? [
            PopupMenuButton<dynamic>(
                color: Colors.white,
                icon: const Icon(Icons.menu),
                itemBuilder: (_) => HomeAction.actions
                    .map((action) => PopupMenuItem(
                        child: Text(action.text), onTap: () => controller.tapAction(action), value: action.text))
                    .toList())
          ]
        : HomeAction.actions.map(_buildAppBarAction).toList();
    return AppBar(
        centerTitle: false,
        title: Text('芝麻开门', style: TextStyle(fontSize: appBarTitleFont)),
        titleSpacing: isSmallScreen ? 15 : 100,
        actions: actions,
        backgroundColor: Colors.transparent);
  }

  Widget _buildAppBarAction(HomeAction action) {
    final textItem = Text(action.text, style: TextStyle(fontSize: smallFont));
    return TextButton(
      onPressed: () => controller.tapAction(action),
      child: textItem,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.hovered) ? Colors.white.withOpacity(0.9) : Colors.transparent),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 15, vertical: 0)),
        foregroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.hovered) ? Colors.blue : Colors.white),
      ),
    );
  }

  Widget get _body {
    return isSmallScreen
        ? PageView(
            scrollDirection: Axis.vertical,
            children: [
              _pageView,
              SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [_qrItem, const Text('扫描二维码即可体验', style: TextStyle(fontSize: 14))]),
                      const SizedBox(height: 20),
                      _briefItem,
                    ]),
                  ))
            ],
          )
        : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _pageView,
            const SizedBox(width: 40.0),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _briefItem,
                  const SizedBox(height: 50),
                  _qrItem,
                  Text('扫描二维码即可体验', style: TextStyle(fontSize: isSmallScreen ? 12.0 : 14.0))
                ]),
          ]);
  }

  Widget get _pageView {
    final size = Size(isSmallScreen ? Get.width : 370, isSmallScreen ? Get.height - kToolbarHeight : 800);
    return ConstrainedBox(
        constraints: BoxConstraints.loose(size),
        child: Swiper(
            itemCount: 5,
            pagination: const SwiperPagination(),
            itemBuilder: (_, index) => Image.asset('/sample${index + 1}.jpg', fit: BoxFit.contain)));
  }

  Widget get _briefItem => Text.rich(
        TextSpan(
          text: '芝麻开门\n',
          style: TextStyle(fontSize: maxFont, fontWeight: FontWeight.w500),
          children: [
            TextSpan(text: '\n前后端全栈\n基于图片分享功能的演示App', style: TextStyle(fontSize: defaultFont))
          ],
        ),
      );

  Widget get _qrItem => QrImage(
        padding: EdgeInsets.zero,
        data: "http://39.107.136.94/sesame/doc/index.html",
        version: QrVersions.auto,
        foregroundColor: Colors.white,
        size: isSmallScreen ? 120.0 : 180.0,
      );
}
