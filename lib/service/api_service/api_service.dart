import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:ml_gallery/utils/constants.dart';
import 'package:ml_gallery/extensions.dart';

class ApiService {
  static final Dio _dio = Dio()..options.baseUrl = baseUrl;

  static var _box = Hive.box(storeName);

  static Future<Response> getMethod(String endPoints,
      {bool allowBaseUrl = true}) async {
    try {
      Dio _kDio = Dio();
      Response response =
          allowBaseUrl ? await _dio.get(endPoints) : await _kDio.get(endPoints);
      if (!_box.isOpen) {
        _box = await Hive.openBox(storeName);
      }
      _box.put(response.realUri.toString(), {"data": response.data});
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.other) {
        if (_box.containsKey(baseUrl + endPoints)) {
          var data = HashMap.from(_box.get(baseUrl + endPoints));
          return Response(
            requestOptions: RequestOptions(
              path: endPoints.getPath(),
            ),
            data: data['data'],
          );
        }
      }
      rethrow;
    }
  }
}
