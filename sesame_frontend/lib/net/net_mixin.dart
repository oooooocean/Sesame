import 'package:get/get.dart';
import 'package:sesame_frontend/models/net_response.dart';
import 'package:sesame_frontend/net/net.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

mixin NetMixin {
  Future<T> get<T>(String uri, Map<String, dynamic> query, Decoder<T> decoder) async {
    final res = (await Net().get<NetResponse>(uri, query: query)).body;
    return _parse(res, decoder);
  }

  Future<T> post<T>(String uri, Map<String, dynamic> body, Decoder<T> decoder) async {
    final res = (await Net().post<NetResponse>(uri, body, contentType: 'application/json')).body;
    return _parse(res, decoder);
  }

  Future<T> delete<T>(String uri, Map<String, dynamic> query, Decoder<T> decoder) async {
    final res = (await Net().delete<NetResponse>(uri, query: query)).body;
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
    final res = (await Net().post(uri, formData, query: query, contentType: 'multipart/form-data')).body;
    return _parse(res, decoder);
  }

  Future<T> _parse<T>(NetResponse? res, Decoder<T> decoder) async {
    if (res == null) throw NetError()..message = '服务端返回无法解析';
    if (res.code != NetCode.success) throw res;
    return decoder(res.data);
  }
}
