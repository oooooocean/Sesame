import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sesame_frontend/components/mixins/load_image_mixin.dart';
import 'package:sesame_frontend/components/mixins/separable_page_mixin.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';
import 'package:sesame_frontend/models/paging_data.dart';
import 'package:sesame_frontend/pages/post/list/post_list_controller.dart';
import 'package:sesame_frontend/pages/post/views/post_tile.dart';
import 'package:sesame_frontend/route/pages.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostLisState();
}

class _PostLisState extends State<PostListPage>
    with
        ThemeMixin,
        LoadImageMixin,
        AutomaticKeepAliveClientMixin,
        SeparablePageMixin<PostListController, PostListPage> {
  @override
  String get routeName => AppRoutes.postList;

  @override
  Widget get page => Scaffold(appBar: AppBar(), body: body);

  @override
  Widget get body => GetBuilder<PostListController>(
      builder: (_) => SmartRefresher(
            controller: controller.refreshController,
            enablePullUp: true,
            onRefresh: () => controller.load(RefreshType.refresh),
            onLoading: () => controller.load(RefreshType.loadMore),
            child: ListView.separated(
                itemBuilder: _itemBuilder, separatorBuilder: _separatorBuilder, itemCount: controller.items.length),
          ));

  Widget _itemBuilder(BuildContext context, int index) {
    final post = controller.items[index];
    return PostTile(post: post);
  }

  Widget _separatorBuilder(BuildContext context, int index) => Divider(height: 5, thickness: 5, color: borderColor);
}
