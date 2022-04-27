import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';

class CommentHeaderDelegate extends SliverPersistentHeaderDelegate with ThemeMixin {
  final TabController tabController;
  final VoidCallback tapTab;

  CommentHeaderDelegate({required this.tabController, required this.tapTab});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => ColoredBox(
        color: Colors.white,
        child: TabBar(
          padding: const EdgeInsets.symmetric(vertical: 8),
            indicatorColor: Colors.orange,
            labelColor: primaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            controller: tabController,
            onTap: (_) => tapTab(),
            tabs: ['评论', '赞'].map((e) => Tab(text: e)).toList()),
      );

  @override
  double get maxExtent => 46.0;

  @override
  double get minExtent => 46.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;

  @override
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration {
    return const PersistentHeaderShowOnScreenConfiguration(
      minShowOnScreenExtent: double.infinity,
    );
  }
}
