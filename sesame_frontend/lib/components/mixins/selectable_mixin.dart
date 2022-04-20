import 'package:json_annotation/json_annotation.dart';

mixin SelectableMixin {
  @JsonKey(ignore: true)
  var selected = false;
}