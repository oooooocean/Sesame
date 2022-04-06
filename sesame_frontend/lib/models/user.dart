import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

enum Gender {
  @JsonValue(1)
  male,
  @JsonValue(2)
  female
}

@JsonSerializable()
class User {
  var phone = '';
  var id = '';
  UserInfo info;

  User(this.info);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() => '';
}

@JsonSerializable()
class UserInfo {
  var nickname = '';
  var gender = Gender.male;
  var avatar = '';

  UserInfo();

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  @override
  String toString() => '';
}
