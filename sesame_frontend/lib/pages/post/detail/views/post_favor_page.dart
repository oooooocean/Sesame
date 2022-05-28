import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/comps/circle_avatar_button.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';
import 'package:sesame_frontend/pages/post/detail/post_detail_controller.dart';

class PostFavorView extends StatelessWidget with ThemeMixin {
  PostFavorView({Key? key}) : super(key: key);

  PostDetailController get controller => Get.find<PostDetailController>();

  @override
  Widget build(BuildContext context) {
    return SliverList(delegate: SliverChildBuilderDelegate(_childBuilder, childCount: controller.favors.length));
  }

  Widget _childBuilder(BuildContext context, int index) {
    final favor = controller.favors[index];
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 30,
            child: CircleAvatarButton(
                url: favor.avatarUrl, onTap: () => controller.toUserTimeline(favor.favorUserId)),
          ),
          const SizedBox(width: 8),
          Text(favor.favorUser.nickname ?? '', style: TextStyle(color: secondaryColor, fontSize: 13)),
        ]),
      ),
    );
  }
}
