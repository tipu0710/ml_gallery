import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ml_gallery/service/cache_manager/cache_manager.dart';
import 'package:ml_gallery/utils/constants.dart';
import 'package:ml_gallery/extensions.dart';

class ApiService {
  static final Dio _dio = Dio()..options.baseUrl = baseUrl;

  static Future<Response> getMethod(String endPoints,
      {bool allowBaseUrl = true}) async {
    try {
      Dio _kDio = Dio()..options.connectTimeout = 60*1000;
      Response response =
          allowBaseUrl ? await _dio.get(endPoints) : await _kDio.get(endPoints);
      String temp = jsonEncode(response.data);
      temp = temp.replaceAll("“", "");
      temp = temp.replaceAll("”", "");
      await ApiCacheManager.putFile(allowBaseUrl ? (baseUrl + endPoints) : endPoints,
          {"data": jsonDecode(temp)});
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.other) {
        Map<String, dynamic>? data = await ApiCacheManager.getData(
            allowBaseUrl ? (baseUrl + endPoints) : endPoints);
        if (data != null) {
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
