import 'package:flutter/material.dart';
import 'package:ml_gallery/ui/home/model/image_info_model.dart';

class PhotoModelProviders extends ChangeNotifier {
  ImageInfoModel? _imageInfoModel;

  ImageInfoModel? get imageInfoModel => _imageInfoModel;

  setModel(ImageInfoModel imageInfoModel) {
    if (_imageInfoModel == null || _imageInfoModel!.id != imageInfoModel.id) {
      _imageInfoModel = imageInfoModel;
      notifyListeners();
    }
  }
}
