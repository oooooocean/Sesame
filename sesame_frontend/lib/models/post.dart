import 'package:json_annotation/json_annotation.dart';
import 'package:sesame_frontend/models/photo.dart';
import 'package:sesame_frontend/models/user.dart';
import 'package:sesame_frontend/services/utils.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  final int id;
  String description;
  @JsonKey(fromJson: convertTimestampToDatetime)
  DateTime createTime;
  @JsonKey(fromJson: convertTimestampToDatetime)
  DateTime updateTime;
  int ownerId;
  List<Photo> photos;
  UserInfo owner;
  int shareCount;
  int commentCount;
  int favorCount;

  Post(this.id, this.description, this.createTime, this.updateTime, this.ownerId, this.photos, this.owner,
      this.shareCount, this.commentCount, this.favorCount);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  String toString() => '';
}
