import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:ml_gallery/utils/constants.dart';
import 'package:ml_gallery/extensions.dart';

class ApiService {
  static final Dio _dio = Dio()..options.baseUrl = baseUrl;

  static var _box = Hive.box(storeName);

  static Future<Response> getMethod(String endPoints) async {
    try {
      Response response = await _dio.get(endPoints);
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
          print(data.runtimeType);
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
