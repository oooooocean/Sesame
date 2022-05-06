import 'package:flutter/material.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';

enum PostHandlerType { share, comment, favor }

mixin PostHandlerMixin {
  Widget buildAction(PostHandlerType type, String title, ValueSetter<PostHandlerType>? onTap, {bool accent = false}) {
    IconData iconData;
    switch (type) {
      case PostHandlerType.share:
        iconData = Icons.share;
        break;
      case PostHandlerType.comment:
        iconData = Icons.comment;
        break;
      case PostHandlerType.favor:
        iconData = accent ? Icons.favorite : Icons.favorite_border;
        break;
    }
    Color color = accent ? Colors.orange : const Color(0xff878787);
    return TextButton.icon(
      onPressed: onTap != null ? () => onTap(type) : null,
      icon: Icon(iconData, color: color, size: 20),
      label: Text(title, style: TextStyle(color: color)),
    );
  }
}

class PostHandlerDisplayTile extends StatelessWidget with ThemeMixin, PostHandlerMixin {
  final int shareCount;
  final int commentCount;
  final int favorCount;

  const PostHandlerDisplayTile(
      {Key? key, required this.shareCount, required this.commentCount, required this.favorCount})
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
        value = favorCount;
        break;
    }
    return buildAction(type, value.toString(), null);
  }
}

class PostHandlerTile extends StatelessWidget with ThemeMixin, PostHandlerMixin {
  final ValueSetter<PostHandlerType> onTap;
  final bool hasFavor;

  const PostHandlerTile({Key? key, required this.onTap, required this.hasFavor}) : super(key: key);

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
    var accent = false;
    switch (type) {
      case PostHandlerType.share:
        value = 'Share';
        break;
      case PostHandlerType.comment:
        value = 'Comment';
        break;
      case PostHandlerType.favor:
        value = 'Favor';
        accent = hasFavor;
        break;
    }
    return buildAction(type, value, onTap, accent: accent);
  }
}
