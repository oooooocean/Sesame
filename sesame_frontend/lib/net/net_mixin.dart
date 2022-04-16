import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/models/net_response.dart';
import 'package:sesame_frontend/net/net.dart';
import 'package:sesame_frontend/services/launch_service.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

mixin NetMixin {
  final net = Net();

  String? shouldRequest() => null;

  Future? request<T>(Future<T> future, {ValueSetter<T>? success, ValueSetter<Error>? fail}) async {
    final errorMsg = shouldRequest();
    if (errorMsg != null) {
      EasyLoading.showToast(errorMsg);
      return;
    }

    EasyLoading.show();
    return future.then((value) {
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

  Future<T> postFormData<T>(String uri, Map<String, dynamic> query, List<AssetEntity> files, Decoder<T> decoder,
      {bool originSize = false}) {
    // 构建 MultipartFile
    final filesFutures = files.map((entity) {
      Future<Uint8List?> bytes;
      if (originSize) {
        bytes = entity.originBytes;
      } else {
        final size = ThumbnailSize((min(Get.width * Get.pixelRatio, entity.size.width)).toInt(),
            (min(Get.height * Get.pixelRatio, entity.size.height).toInt()));
        bytes = entity.thumbnailDataWithSize(size, quality: 50, format: ThumbnailFormat.jpeg);
      }
      return bytes.then((value) {
        if (value == null) return null;
        return MultipartFile(value.toList(), filename: entity.title ?? '');
      });
    }).toList();
    // 请求
    return Future.wait(filesFutures).then((files) {
      final validFiles = files.where((element) => element != null).map((e) => e!).toList();

      return net.post(uri, FormData({'images': validFiles}),
          query: query, contentType: 'multipart/form-data', decoder: net.defaultDecoder);
    }).then((res) => _parse(res.body, decoder));

    // List<MultipartFile> list = [];
    // for (var entity in files) {
    //   final bytes = await entity.thumbnailDataWithSize(
    //       ThumbnailSize((Get.width * Get.pixelRatio).toInt(), (Get.height * Get.pixelRatio).toInt()));
    //   if (bytes == null) continue;
    //   list.add(MultipartFile(bytes.toList(), filename: entity.title ?? ''));
    // }
    // final formData = FormData({'images': list});
    // final res =
    //     (await net.post(uri, formData, query: query, contentType: 'multipart/form-data', decoder: net.defaultDecoder))
    //         .body;
    // return _parse(res, decoder);
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
