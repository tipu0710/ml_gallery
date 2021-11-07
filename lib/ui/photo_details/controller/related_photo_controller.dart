import 'package:dio/dio.dart';
import 'package:ml_gallery/service/api_service/api_service.dart';
import 'package:ml_gallery/ui/photo_details/model/related_photo_model.dart';

class RelatedPhotoController {
  Future<RealtedPhotoModel> getModel(String urlId) async {
    Response response = await ApiService.getMethod(
        "https://unsplash.com/napi/photos/$urlId/related",
        allowBaseUrl: false);

    RealtedPhotoModel realtedPhotoModel =
        RealtedPhotoModel.fromJson(response.data);

    return realtedPhotoModel;
  }
}
