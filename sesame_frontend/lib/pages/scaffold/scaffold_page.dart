import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/load_image_mixin.dart';
import 'package:sesame_frontend/pages/album/list/album_list_page.dart';
import 'package:sesame_frontend/pages/post/list/post_list_page.dart';
import 'package:sesame_frontend/pages/scaffold/scaffold_controller.dart';
import 'package:sesame_frontend/pages/user/user_info_page.dart';

class ScaffoldPage extends StatefulWidget {
  const ScaffoldPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends State<ScaffoldPage> with SingleTickerProviderStateMixin, LoadImageMixin {
  final _tabs = ['ALBUMS', 'SESAME'];
  late TabController _tabController;

  ScaffoldController get controller => Get.find<ScaffoldController>();

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    controller.tabController = _tabController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(appBar: _appBar, body: _tabBarView, drawer: const UserInfoPage());

  AppBar get _appBar => AppBar(
        title: _tabBar,
        leading: Builder(
            builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.home_rounded, color: Colors.white))),
        actions: [IconButton(onPressed: controller.tapRightAction, icon: const Icon(Icons.add, color: Colors.white))],
      );

  TabBar get _tabBar => TabBar(
      controller: _tabController,
      tabs: _tabs.map((item) => Tab(text: item)).toList(),
      indicator: const BoxDecoration());

  TabBarView get _tabBarView =>
      TabBarView(controller: _tabController, children: const [AlbumListPage(), PostListPage()]);
}
