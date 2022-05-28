import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sesame_frontend/components/mixins/load_image_mixin.dart';
import 'package:sesame_frontend/components/mixins/selectable_mixin.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo with LoadImageMixin, SelectableMixin {
  int id;
  String name;
  String? description;
  bool favor;
  int userId;

  Photo(this.id, this.name, this.description, this.favor, this.userId);

  factory Photo.fromJson(Map<String, dynamic> json) =>  _$PhotoFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoToJson(this);

  @override
  String toString() => '图片: $name';

  String get thumbnailUrl => buildNetImageUrl(name, width: Get.width / 3, userId: userId);

  String get url => buildNetImageUrl(name, userId: userId, width: Get.width, height: Get.height);
}