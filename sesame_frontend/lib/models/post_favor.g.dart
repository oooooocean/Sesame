// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_favor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostFavor _$PostFavorFromJson(Map<String, dynamic> json) => PostFavor(
      json['id'] as int,
      convertTimestampToDatetime(json['createTime']),
      json['postId'] as int,
      UserInfo.fromJson(json['favorUser'] as Map<String, dynamic>),
      json['favorUserId'] as int,
    );

Map<String, dynamic> _$PostFavorToJson(PostFavor instance) => <String, dynamic>{
      'id': instance.id,
      'createTime': instance.createTime.toIso8601String(),
      'postId': instance.postId,
      'favorUserId': instance.favorUserId,
      'favorUser': instance.favorUser,
    };
