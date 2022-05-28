import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sesame_frontend/components/mixins/load_image_mixin.dart';
import 'package:sesame_frontend/models/user.dart';
import 'package:sesame_frontend/services/utils.dart';

part 'post_comment.g.dart';

@JsonSerializable()
class PostComment with LoadImageMixin {
  int id;
  String comment;
  int commentUserId;
  int postId;
  UserInfo commentUser;
  @JsonKey(fromJson: convertTimestampToDatetime)
  DateTime createTime;

  PostComment(this.id, this.comment, this.commentUserId, this.postId, this.commentUser, this.createTime);

  factory PostComment.fromJson(Map<String, dynamic> json) =>  _$PostCommentFromJson(json);
  Map<String, dynamic> toJson() => _$PostCommentToJson(this);

  @override
  String toString() => '';

  String get avatarUrl => buildNetImageUrl(commentUser.avatar ?? '', width: Get.width / 3, userId: commentUserId);
}