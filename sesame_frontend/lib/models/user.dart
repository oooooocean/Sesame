import 'dart:convert';

import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sesame_frontend/components/mixins/load_image_mixin.dart';
import 'package:sesame_frontend/services/store.dart';

part 'user.g.dart';

enum Gender {
  @JsonValue(1)
  male,
  @JsonValue(2)
  female
}

extension GenderExtension on Gender {
  String get string => ['Male', 'Female'][index];
}

@JsonSerializable()
class User with LoadImageMixin {
  String phone;
  int id;
  UserInfo? info;

  User(this.id, this.phone, this.info);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() => 'User: $phone';

  void save() => Store.set('user', const JsonEncoder().convert(toJson()));

  static Future<User?> cached() =>
      Store.get('user', decoder: (data) => User.fromJson(const JsonDecoder().convert(data)));

  String get thumbnailUrl => buildNetImageUrl(info?.avatar ?? '', width: Get.width / 4, userId: id);
}

@JsonSerializable()
class UserInfo {
  String? nickname;
  Gender? gender;
  String? avatar;

  UserInfo();

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  @override
  String toString() => '';

  bool get isCompletion => (nickname?.isNotEmpty ?? false) && gender != null && avatar != null;
}
