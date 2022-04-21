// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      json['id'] as int,
      json['description'] as String,
      convertTimestampToDatetime(json['createTime'] as int),
      convertTimestampToDatetime(json['updateTime'] as int),
      json['ownerId'] as int,
      (json['photos'] as List<dynamic>)
          .map((e) => Photo.fromJson(e as Map<String, dynamic>))
          .toList(),
      UserInfo.fromJson(json['owner'] as Map<String, dynamic>),
      json['shareCount'] as int,
      json['commentCount'] as int,
      json['favorCount'] as int,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'createTime': instance.createTime.toIso8601String(),
      'updateTime': instance.updateTime.toIso8601String(),
      'ownerId': instance.ownerId,
      'photos': instance.photos,
      'owner': instance.owner,
      'shareCount': instance.shareCount,
      'commentCount': instance.commentCount,
      'favorCount': instance.favorCount,
    };
