import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sesame_www/pages/home/home_page_controller.dart';

class HomePage extends GetView<HomePageController> {
  final _pageController = PageController();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          centerTitle: false,
          title: const Text('芝麻开门', style: TextStyle(fontFamily: 'Sesame', fontSize: 30)),
          titleSpacing: 100,
          actions: [
            _buildAppBarAction('Github', () {}),
            _buildAppBarAction('申请内测', () {}),
            _buildAppBarAction('联系作者', () {}),
            const SizedBox(width: 100)
          ],
          backgroundColor: Colors.transparent),
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('/bg.jpeg'), fit: BoxFit.cover)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ConstrainedBox(constraints: BoxConstraints.loose(const Size(370, 800)), child: _pageView),
          const SizedBox(width: 40.0),
          DefaultTextStyle(
            style: const TextStyle(color: Colors.white),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _briefItem,
                  const SizedBox(height: 50),
                  _qrItem,
                  const Text('扫描二维码即可体验', style: TextStyle(fontSize: 14))
                ]),
          )
        ]),
      ),
    );
  }

  Widget _buildAppBarAction(String text, VoidCallback action, {Widget? icon}) {
    final textItem = Text(text, style: const TextStyle(fontSize: 15));
    return TextButton(
      onPressed: () {},
      child: icon == null ? textItem : Row(children: [icon, textItem]),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.hovered) ? Colors.white.withOpacity(0.9) : Colors.transparent),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 15, vertical: 0)),
        foregroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.hovered) ? Colors.blue : Colors.white),
      ),
    );
  }

  Widget get _pageView {
    return Swiper(
        itemCount: 5,
        pagination: const SwiperPagination(),
        itemBuilder: (_, index) => Image.asset('/sample${index + 1}.jpg'));
  }

  Widget get _briefItem => const Text.rich(
        TextSpan(
          text: '芝麻开门\n',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
          children: [TextSpan(text: '\n前后端全栈\n基于图片分享功能的演示App', style: TextStyle(fontSize: 20))],
        ),
      );

  Widget get _qrItem => QrImage(
        padding: EdgeInsets.zero,
        data: "http://39.107.136.94/sesame/doc/index.html",
        version: QrVersions.auto,
        foregroundColor: Colors.white,
        size: 180.0,
      );
}
