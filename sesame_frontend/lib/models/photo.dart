import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo {
  int id;
  String name;
  String? description;
  bool favor;

  Photo(this.id, this.name, this.description, this.favor);

  factory Photo.fromJson(Map<String, dynamic> json) =>  _$PhotoFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoToJson(this);

  @override
  String toString() => '图片: $name';
}