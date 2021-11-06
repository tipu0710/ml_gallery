// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:ml_gallery/service/api_service/api_service.dart';
import 'package:ml_gallery/ui/home/model/image_info_model.dart';

class ImageLibraryController {
  Future<List<ImageInfoModel>> getImageList(int page) async {
    List<ImageInfoModel> imageModelList = [];
    try {
      Response response = await ApiService.getMethod("/v2/list?page=$page");
      Iterable list = response.data;

      for (var element in list) {
        final Map<String, dynamic> data = Map.from(element);
        imageModelList.add(ImageInfoModel.fromJson(data));
      }
    } catch (e) {
      print(e);
    }
    return imageModelList;
  }
}
