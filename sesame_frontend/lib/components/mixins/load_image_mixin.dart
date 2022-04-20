import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sesame_frontend/services/app_configuration.dart';
import 'package:sesame_frontend/services/launch_service.dart';

mixin LoadImageMixin {
  Image buildAssetImage(String name, {double? width, BoxFit fit = BoxFit.fitWidth}) =>
      Image.asset('assets/images/$name.png', width: width, fit: fit);

  Image buildNetImage(String url, {BoxFit fit = BoxFit.fitWidth, double? width, double? height, Alignment alignment = Alignment.center}) {
    Widget placeholder = const Center(child: CupertinoActivityIndicator());
    return Image.network(url,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.error, size: 20.0)),
        loadingBuilder: (ctx, child, progress) => progress == null ? child : placeholder);
  }

  String buildNetImageUrl(String imageName, {double? width, double? height}) {
    Map<String, dynamic> query = {'user_id': (Get.find<LaunchService>().user?.id ?? '').toString()};
    if (width != null) query['width'] = (width * Get.pixelRatio).toString();
    if (height != null) query['height'] = (height * Get.pixelRatio).toString();
    final host = Uri.parse(serviceHost);
    final uri = Uri(
        scheme: host.scheme,
        host: host.host,
        port: host.port,
        path: host.path + 'pic/' + imageName,
        queryParameters: query);
    return uri.toString();
  }
}
