import 'package:flutter/material.dart';
import 'package:sesame_frontend/components/mixins/load_image_mixin.dart';
import 'package:sesame_frontend/components/mixins/theme_mixin.dart';
import 'package:sesame_frontend/models/photo.dart';

class PhotoThumbnailTile extends StatelessWidget with ThemeMixin, LoadImageMixin {
  final VoidCallback onTap;
  final Photo photo;
  final VoidCallback? onTapCorner;

  PhotoThumbnailTile({Key? key, required this.photo, required this.onTap, this.onTapCorner}) : super(key: key);

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
                opacity: 0.85,
                child: Hero(tag: photo.name, child: buildNetImage(photo.thumbnailUrl, fit: BoxFit.cover))),
            _cornerItem
          ],
        ),
        clipBehavior: Clip.hardEdge,
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(accentColor),
            elevation: MaterialStateProperty.all(1),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))))),
      );

  bool get _shouldStar => onTapCorner == null;

  Widget get _cornerItem => _shouldStar
      ? Positioned(right: 5, bottom: 5, child: Icon(Icons.star, color: photo.favor ? Colors.yellow : Colors.grey))
      : Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            onPressed: onTapCorner,
            icon: Icon(photo.selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: photo.selected ? Colors.green : Colors.white),
          ),
        );
}
