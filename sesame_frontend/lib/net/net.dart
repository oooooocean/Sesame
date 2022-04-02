import 'dart:io';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:sesame_frontend/models/net_response.dart';

class Net extends GetConnect {
  Net() : super(timeout: const Duration(seconds: 30), userAgent: 'Sesame-Client') {
    httpClient.addRequestModifier<Object?>((request) {
      log("---- 请求 ----\n method: ${request.method} \nurl: ${request.url.path} \n参数: ${request.url.queryParameters}");
      request.headers['Sesame-Platform'] = _platform;
      return request;
    });

    httpClient.addResponseModifier((request, response) {
      if (response.headers?['content-type'] != 'application/json') return response;
      log("---- 响应 ----\n${response.bodyString ?? ''}");
      return response;
    });
  }

  @override
  String get baseUrl => '192.168.29.11:8000/v1';

  @override
  Decoder<NetResponse> get defaultDecoder => (data) => NetResponse.fromJson(data);

  String get _platform {
    if (Platform.isIOS) {
      return 'iOS';
    } else if (Platform.isAndroid) {
      return 'android';
    } else {
      return 'web';
    }
  }
}
