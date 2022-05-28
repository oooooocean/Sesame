import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sesame_frontend/components/mixins/load_image_mixin.dart';
import 'package:sesame_frontend/models/user.dart';
import 'package:sesame_frontend/services/utils.dart';

part 'post_favor.g.dart';

@JsonSerializable()
class PostFavor with LoadImageMixin {
  int id;
  @JsonKey(fromJson: convertTimestampToDatetime)
  DateTime createTime;
  int postId;
  int favorUserId;
  UserInfo favorUser;

  PostFavor(this.id, this.createTime, this.postId, this.favorUser, this.favorUserId);

  factory PostFavor.fromJson(Map<String, dynamic> json) => _$PostFavorFromJson(json);

  Map<String, dynamic> toJson() => _$PostFavorToJson(this);

  @override
  String toString() => '';

  String get avatarUrl => buildNetImageUrl(favorUser.avatar ?? '', userId: favorUserId, width: Get.width / 4);
}
