import 'package:json_annotation/json_annotation.dart';

enum PetGender {
  @JsonValue(0)
  unknow,
  @JsonValue(1)
  male,
  @JsonValue(2)
  female
}

enum Variety {
  @JsonValue(1)
  samoyed,
  @JsonValue(2)
  goldenRetriever
}

@JsonSerializable()
class PetInfo {
  String? nickname;
  PetGender? gender;
  String? avatar;
  Variety? variety;
  DateTime? birthday;
  String? signature;

  PetInfo();

  @override
  String toString() => '';
  // 是否完成宠物信息填写
  bool get isCompleted =>
      (nickname?.isNotEmpty ?? false) &&
      gender != null &&
      avatar != null &&
      variety != null &&
      birthday != null;
}
