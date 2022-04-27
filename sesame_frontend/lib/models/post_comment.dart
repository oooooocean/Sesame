import 'package:json_annotation/json_annotation.dart';
import 'package:sesame_frontend/models/user.dart';
import 'package:sesame_frontend/services/utils.dart';

part 'post_comment.g.dart';

@JsonSerializable()
class PostComment {
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
}