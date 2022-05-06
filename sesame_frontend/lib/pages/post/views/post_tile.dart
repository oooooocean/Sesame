import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/components/comps/circle_avatar_button.dart';
import 'package:sesame_frontend/components/mixins/load_image_mixin.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';
import 'package:sesame_frontend/models/post.dart';
import 'package:sesame_frontend/pages/post/list/post_list_controller.dart';
import 'package:sesame_frontend/pages/post/views/post_handler_tile.dart';
import 'package:sesame_frontend/pages/post/views/post_photos_tile.dart';

class PostTile extends GetView<PostListController> with LoadImageMixin, ThemeMixin {
  final Post post;
  final space = const SizedBox(height: 5);
  final bool panel;

  PostTile({Key? key, required this.post, this.panel = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children = [
      space,
      _headerItem,
      space,
      _descriptionItem,
      space,
      _photosItem,
      space,
    ];
    if (panel) children.addAll([const Divider(), _panel]);

    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
      ),
    );
  }

  Widget get _headerItem => SizedBox(
        height: 50,
        child: Row(
          children: [
            _avatarItem,
            const SizedBox(width: 5),
            Text(post.owner.nickname ?? 'UNKNOWN', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
      );

  Widget get _avatarItem => CircleAvatarButton(url: post.owner.thumbnailUrl, onTap: () => controller.onTapAvatar(post));

  Widget get _descriptionItem => Text(post.description, style: TextStyle(color: primaryColor, fontSize: 15));

  Widget get _photosItem => PostPhotosTile(photos: post.photos, onTap: (index) => controller.onTapPhoto(post, index));

  Widget get _panel => SizedBox(
        height: 40,
        child: PostHandlerDisplayTile(
            shareCount: post.shareCount,
            commentCount: post.commentCount,
            favorCount: post.favorCount,
            onTap: (type) => controller.onTapAction(post, type)),
      );
}
