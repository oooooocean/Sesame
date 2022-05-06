import 'package:flutter/material.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';

enum PostHandlerType { share, comment, favor }

mixin PostHandlerMixin {
  Widget buildAction(PostHandlerType type, String title, ValueSetter<PostHandlerType> onTap) {
    IconData iconData;
    switch (type) {
      case PostHandlerType.share:
        iconData = Icons.share;
        break;
      case PostHandlerType.comment:
        iconData = Icons.comment;
        break;
      case PostHandlerType.favor:
        iconData = Icons.favorite_border;
        break;
    }
    return TextButton.icon(
      onPressed: () => onTap(type),
      icon: Icon(iconData, color: const Color(0xff878787), size: 20),
      label: Text(title, style: const TextStyle(color: Color(0xff878787))),
    );
  }
}

class PostHandlerDisplayTile extends StatelessWidget with ThemeMixin, PostHandlerMixin {
  final int shareCount;
  final int commentCount;
  final int favorCount;
  final ValueSetter<PostHandlerType> onTap;

  const PostHandlerDisplayTile(
      {Key? key, required this.shareCount, required this.commentCount, required this.favorCount, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: PostHandlerType.values.map(_buildAction).toList(),
      );

  Widget _buildAction(PostHandlerType type) {
    int value;
    switch (type) {
      case PostHandlerType.share:
        value = shareCount;
        break;
      case PostHandlerType.comment:
        value = commentCount;
        break;
      case PostHandlerType.favor:
        value = shareCount;
        break;
    }
    return buildAction(type, value.toString(), onTap);
  }
}

class PostHandlerTile extends StatelessWidget with ThemeMixin, PostHandlerMixin {
  final ValueSetter<PostHandlerType> onTap;

  const PostHandlerTile({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: PostHandlerType.values.map(_buildAction).toList(),
        ),
  );

  Widget _buildAction(PostHandlerType type) {
    String value;
    switch (type) {
      case PostHandlerType.share:
        value = 'Share';
        break;
      case PostHandlerType.comment:
        value = 'Comment';
        break;
      case PostHandlerType.favor:
        value = 'Favor';
        break;
    }
    return buildAction(type, value, onTap);
  }
}
