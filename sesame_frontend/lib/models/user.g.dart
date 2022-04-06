// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      UserInfo.fromJson(json['info'] as Map<String, dynamic>),
    )
      ..phone = json['phone'] as String
      ..id = json['id'] as String;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'phone': instance.phone,
      'id': instance.id,
      'info': instance.info,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo()
  ..nickname = json['nickname'] as String
  ..gender = $enumDecode(_$GenderEnumMap, json['gender'])
  ..avatar = json['avatar'] as String;

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'nickname': instance.nickname,
      'gender': _$GenderEnumMap[instance.gender],
      'avatar': instance.avatar,
    };

const _$GenderEnumMap = {
  Gender.male: 1,
  Gender.female: 2,
};
