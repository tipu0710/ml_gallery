import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:share/share.dart';

class PhotoDetailsController {
  Future<File?> getFile(String imageUrl) async {
    final cache = DefaultCacheManager();
    FileInfo? file = await cache.getFileFromCache(imageUrl);
    print(file?.file.path);
    return file?.file;
  }

  Future<bool> share(String url) async {
    File? file = await getFile(url);
    if (file != null) {
      await Share.shareFiles([file.path], text: 'ML Gallery picture');
      return true;
    } else {
      return false;
    }
  }
}
