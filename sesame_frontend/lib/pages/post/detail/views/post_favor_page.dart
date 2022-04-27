import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/comps/circle_avatar_button.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';
import 'package:sesame_frontend/pages/post/detail/views/post_favor_controller.dart';

class PostFavorView extends GetView<PostFavorController> with ThemeMixin {
  const PostFavorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostFavorController>(
      builder: (_) =>
          SliverList(delegate: SliverChildBuilderDelegate(_childBuilder, childCount: controller.items.length)),
    );
  }

  Widget _childBuilder(BuildContext context, int index) {
    final favor = controller.items[index];
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 50,
        child: CircleAvatarButton(
            url: favor.favorUser.thumbnailUrl, onTap: () => controller.toUserTimeline(favor.favorUserId)),
      ),
      const SizedBox(width: 8),
      Text(favor.favorUser.nickname ?? '', style: TextStyle(color: secondaryColor, fontSize: 13)),
    ]);
  }
}
