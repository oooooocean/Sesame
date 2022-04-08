// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'net_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetResponse _$NetResponseFromJson(Map<String, dynamic> json) => NetResponse(
      $enumDecode(_$NetCodeEnumMap, json['code']),
      json['data'],
    )..msg = json['msg'] as String;

Map<String, dynamic> _$NetResponseToJson(NetResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': _$NetCodeEnumMap[instance.code],
      'data': instance.data,
    };

const _$NetCodeEnumMap = {
  NetCode.success: 0,
  NetCode.noAuth: 1000,
  NetCode.loginOverdue: 1003,
  NetCode.clientError: 1007,
  NetCode.serverError: 1008,
};
