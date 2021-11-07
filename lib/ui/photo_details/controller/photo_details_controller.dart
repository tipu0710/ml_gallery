import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share/share.dart';

class PhotoDetailsController {
  Future<File?> getFile(String imageUrl) async {
    final cache = DefaultCacheManager();
    FileInfo? file = await cache.getFileFromCache(imageUrl);
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

  Future<bool> savePhoto(File file) async {
    bool? save = await GallerySaver.saveImage(file.path);
    return save ?? false;
  }
}
