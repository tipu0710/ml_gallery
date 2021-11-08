import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:ml_gallery/ui/photo_details/view/full_screen_photo.dart';
import 'package:ml_gallery/utils/hero_route.dart';
import 'package:ml_gallery/utils/utils.dart';
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

  Future<bool> _savePhoto(File file) async {
    bool? save = await GallerySaver.saveImage(file.path);
    return save ?? false;
  }

    savePhoto(BuildContext context, String url) async {
    File? file =
        await getFile(url);
    if (file == null) {
      Utils.showSnackBar(
          context, "Something went wrong! cannot save the photo!",
          durationInMiliseconds: 2000);
    } else {
      bool save = await _savePhoto(file);
      Utils.showSnackBar(
          context, save ? "Photo saved!" : "Unable to save the photo!");
    }
  }

    openImage(BuildContext context, String url) {
    Navigator.push(
      context,
      HeroRoute(
        builder: (_) => FullScreenPhoto(url: url),
      ),
    );
  }
}
