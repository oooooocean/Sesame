// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostComment _$PostCommentFromJson(Map<String, dynamic> json) => PostComment(
      json['id'] as int,
      json['comment'] as String,
      json['commentUserId'] as int,
      json['postId'] as int,
      UserInfo.fromJson(json['commentUser'] as Map<String, dynamic>),
      convertTimestampToDatetime(json['createTime'] as int),
    );

Map<String, dynamic> _$PostCommentToJson(PostComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'commentUserId': instance.commentUserId,
      'postId': instance.postId,
      'commentUser': instance.commentUser,
      'createTime': instance.createTime.toIso8601String(),
    };
