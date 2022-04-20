import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/mixins/load_image_mixin.dart';
import 'package:sesame_frontend/components/mixins/separable_page_mixin.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';
import 'package:sesame_frontend/pages/album/list/album_list_controller.dart';
import 'package:sesame_frontend/route/pages.dart';

class AlbumListPage extends StatefulWidget {
  const AlbumListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumListPage>
    with
        AutomaticKeepAliveClientMixin,
        ThemeMixin,
        LoadImageMixin,
        SeparablePageMixin<AlbumListController, AlbumListPage> {
  final double coverHeight = 150.0;

  @override
  String get routeName => AppRoutes.albumList;

  @override
  Widget get page => Scaffold(
      appBar: AppBar(
        title: buildAssetImage('logo', width: 25),
        leading: Builder(
            builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.home_rounded, color: Colors.white))),
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(AppRoutes.albumCreate), icon: const Icon(Icons.add, color: Colors.white))
        ],
      ),
      body: body);

  @override
  Widget get body => controller.obx(
        (state) => ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
            itemBuilder: _itemBuilder,
            separatorBuilder: _separatorBuilder,
            itemCount: controller.albums.length),
        onError: (msg) => Center(child: Text(msg ?? '')),
        onLoading: const Center(
          child: CupertinoActivityIndicator(),
        ),
      );

  Widget _itemBuilder(BuildContext context, int index) {
    final album = controller.albums[index];
    return TextButton(
      onPressed: () => controller.selected(album),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
              opacity: 0.85,
              child: buildNetImage(buildNetImageUrl(album.cover, height: coverHeight), fit: BoxFit.cover)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
            child: DefaultTextStyle(
              style: TextStyle(color: primaryColor),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  album.name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(album.description ?? '')
              ]),
            ),
          )
        ],
      ),
      clipBehavior: Clip.hardEdge,
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(accentColor),
          elevation: MaterialStateProperty.all(5),
          fixedSize: MaterialStateProperty.all(Size.fromHeight(coverHeight)),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))))),
    );
  }

  Widget _separatorBuilder(BuildContext context, int index) => const Divider(color: Colors.transparent, height: 10);
}
