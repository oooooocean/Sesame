import 'package:flutter/material.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';

enum PostHandlerType { share, comment, favor }

class PostHandlerTile extends StatelessWidget with ThemeMixin {
  final int shareCount;
  final int commentCount;
  final int favorCount;
  final ValueSetter<PostHandlerType> onTap;

  const PostHandlerTile(
      {Key? key, required this.shareCount, required this.commentCount, required this.favorCount, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: PostHandlerType.values.map(_buildAction).toList(),
      );

  Widget _buildAction(PostHandlerType type) {
    IconData iconData;
    int value;
    switch (type) {
      case PostHandlerType.share:
        iconData = Icons.share;
        value = shareCount;
        break;
      case PostHandlerType.comment:
        iconData = Icons.comment;
        value = commentCount;
        break;
      case PostHandlerType.favor:
        iconData = Icons.favorite_border;
        value = shareCount;
        break;
    }
    return TextButton.icon(
      onPressed: () => onTap(type),
      icon: Icon(iconData, color: secondaryColor, size: 20),
      label: Text(
        value.toString(),
        style: TextStyle(color: secondaryColor),
      ),
    );
  }
}
