import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/comps/circle_avatar_button.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';
import 'package:sesame_frontend/pages/post/detail/post_detail_controller.dart';
import 'package:sesame_frontend/components/extension/date_extension.dart';

class PostCommentView extends StatelessWidget with ThemeMixin {
  PostCommentView({Key? key}) : super(key: key);

  PostDetailController get controller => Get.find<PostDetailController>();

  @override
  Widget build(BuildContext context) {
    return SliverList(delegate: SliverChildBuilderDelegate(_childBuilder, childCount: controller.comments.length));
  }

  Widget _childBuilder(BuildContext context, int index) {
    final comment = controller.comments[index];
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 30,
            child: CircleAvatarButton(
                url: comment.avatarUrl, onTap: () => controller.toUserTimeline(comment.commentUserId)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(comment.commentUser.nickname ?? '', style: TextStyle(color: secondaryColor, fontSize: 13)),
              Text(comment.comment),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  comment.createTime.yyyymmddhhmm,
                  style: TextStyle(color: greyColor, fontSize: 12),
                ),
              ),
              const Divider(),
            ]),
          )
        ]),
      ),
    );
  }
}
