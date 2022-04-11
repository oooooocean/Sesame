import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sesame_frontend/services/app_configuration.dart';

mixin LoadImageMixin {
  Image buildAssetImage(String name, {double? width, BoxFit fit = BoxFit.fitWidth}) =>
      Image.asset('assets/images/$name.png', width: width, fit: fit);

  Image buildNetImage(String url, {BoxFit fit = BoxFit.fitWidth, double? width, double? height}) {
    Widget placeholder = const Center(child: CupertinoActivityIndicator());
    return Image.network(url,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.error, size: 20.0)),
        loadingBuilder: (ctx, child, progress) => progress == null ? child : placeholder);
  }

  String buildNetImageUrl(String imageName, {double? width, double? height}) {
    Map<String, dynamic> query = {};

    if (width != null) query['width'] = width;
    if (height != null) query['height'] = height;
    return Uri(host: serviceHost, path: 'pic/' + imageName, queryParameters: query).toString();
  }
}