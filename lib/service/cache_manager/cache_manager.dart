import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ApiCacheManager {
  static const _key = 'customCacheKey';
  static final CacheManager _instance = CacheManager(
    Config(
      _key,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
      repo: JsonCacheInfoRepository(databaseName: _key),
    ),
  );

  static Future<void> putFile(String url, Map<String, dynamic> response) async {
    await _instance.putFile(url, _convertJson(response));
  }

  static Uint8List _convertJson(Map<String, dynamic> response) {
    String data = jsonEncode(response);
    var list = data.codeUnits;
    return Uint8List.fromList(list);
  }

  static Future<Map<String, dynamic>?> getData(String url) async {
    try {
      File file = await _instance.getSingleFile(url);
      Uint8List uint8list = await file.readAsBytes();
      String data = String.fromCharCodes(uint8list);
      return jsonDecode(data);
    } catch (e) {
      return null;
    }
  }
}
