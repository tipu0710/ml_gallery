import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ml_gallery/ui/home/model/image_info_model.dart';
import 'package:ml_gallery/extensions.dart';

class PhotoCard extends StatelessWidget {
  final ImageInfoModel imageInfoModel;
  const PhotoCard({Key? key, required this.imageInfoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        image: DecorationImage(
            image: CachedNetworkImageProvider(
                imageInfoModel.downloadUrl!.changeUrl()),
            fit: BoxFit.cover),
      ),
    );
  }
}
