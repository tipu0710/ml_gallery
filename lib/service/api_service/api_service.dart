import 'package:dio/dio.dart';
import 'package:ml_gallery/service/cache_manager/cache_manager.dart';
import 'package:ml_gallery/utils/constants.dart';
import 'package:ml_gallery/extensions.dart';

class ApiService {
  static final Dio _dio = Dio()..options.baseUrl = baseUrl;

  static Future<Response> getMethod(String endPoints,
      {bool allowBaseUrl = true}) async {
    try {
      Dio _kDio = Dio();
      Response response =
          allowBaseUrl ? await _dio.get(endPoints) : await _kDio.get(endPoints);
      ApiCacheManager.putFile(allowBaseUrl ? (baseUrl + endPoints) : endPoints,
          {"data": response.data});
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.other) {
        Map<String, dynamic>? data =
            await ApiCacheManager.getData(baseUrl + endPoints);
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
