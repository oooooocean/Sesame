import 'package:json_annotation/json_annotation.dart';

part 'net_response.g.dart';

enum NetCode {
  @JsonValue(0)
  success,
  @JsonValue(1000)
  noAuth,
  @JsonValue(1003)
  loginOverdue,
  @JsonValue(1007)
  clientError,
  @JsonValue(1008)
  serverError
}

class NetError extends Error {
  String msg = '';

  @override
  String toString() => msg;
}

@JsonSerializable()
class NetResponse extends NetError {
  NetCode code;
  dynamic data;

  NetResponse(this.code, this.data);

  factory NetResponse.fromJson(Map<String, dynamic> json) => _$NetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NetResponseToJson(this);
}
