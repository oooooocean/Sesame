import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/models/net_response.dart';
import 'package:sesame_frontend/net/net.dart';
import 'package:sesame_frontend/services/launch_service.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

mixin NetMixin {
  final net = Net();

  Future request<T>(Future<T> future, {ValueSetter<T>? success, ValueSetter<Error>? fail}) async {
    EasyLoading.show();
    await future.then((value) {
      EasyLoading.dismiss();
      if (success != null) success(value);
    }).catchError((error) {
      EasyLoading.dismiss();
      EasyLoading.showToast(error.toString());
      if (fail != null) fail(error);
    });
  }

  Future<T> get<T>(String uri, Map<String, dynamic> query, Decoder<T> decoder) async {
    final res = (await net.get<NetResponse>(uri, query: query, decoder: net.defaultDecoder)).body;
    return _parse(res, decoder);
  }

  Future<T> post<T>(String uri, Map<String, dynamic> body, Decoder<T> decoder) async {
    final res =
        (await net.post<NetResponse>(uri, body, contentType: 'application/json', decoder: net.defaultDecoder)).body;
    return _parse(res, decoder);
  }

  Future<T> delete<T>(String uri, Map<String, dynamic> query, Decoder<T> decoder) async {
    final res = (await net.delete<NetResponse>(uri, query: query, decoder: net.defaultDecoder)).body;
    return _parse(res, decoder);
  }

  Future<T> postFormData<T>(String uri, Map<String, dynamic> query, List<AssetEntity> files, Decoder<T> decoder) async {
    List<MultipartFile> list = [];
    for (var entity in files) {
      final bytes = await entity.originBytes;
      if (bytes == null) continue;
      list.add(MultipartFile(bytes.toList(), filename: entity.title ?? ''));
    }
    final formData = FormData({'files': list});
    final res =
        (await net.post(uri, formData, query: query, contentType: 'multipart/form-data', decoder: net.defaultDecoder))
            .body;
    return _parse(res, decoder);
  }

  Future<T> _parse<T>(NetResponse? res, Decoder<T> decoder) async {
    if (res == null) throw NetError()..msg = '服务端返回无法解析';
    if (res.code != NetCode.success) {
      if (res.code == NetCode.loginOverdue) {
        Get.find<LaunchService>().restart();
      }
      throw res;
    }
    return decoder(res.data);
  }
}
