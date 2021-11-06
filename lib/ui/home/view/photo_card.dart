import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ml_gallery/ui/home/model/image_info_model.dart';
import 'package:ml_gallery/ui/photo_details/view/photo_details.dart';
import 'package:ml_gallery/utils/hero_route.dart';

class PhotoCard extends StatelessWidget {
  final ImageInfoModel imageInfoModel;
  const PhotoCard({Key? key, required this.imageInfoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        HeroRoute(
          builder: (_) => PhotoDetails(
            imageInfoModel: imageInfoModel,
          ),
        ),
      ),
      child: Hero(
        tag: imageInfoModel.downloadUrl!,
        child: Container(
          height: 70,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                    imageInfoModel.downloadUrl!),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
