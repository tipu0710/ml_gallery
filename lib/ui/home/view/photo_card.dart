import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ml_gallery/ui/home/model/image_info_model.dart';
import 'package:ml_gallery/ui/photo_details/controller/photo_details_controller.dart';
import 'package:ml_gallery/ui/photo_details/view/photo_details.dart';
import 'package:ml_gallery/utils/constants.dart';
import 'package:ml_gallery/utils/hero_route.dart';
import 'package:ml_gallery/utils/utils.dart';

class PhotoCard extends StatelessWidget {
  final ImageInfoModel imageInfoModel;
  const PhotoCard({Key? key, required this.imageInfoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        File? file =
            await PhotoDetailsController().getFile(imageInfoModel.downloadUrl!);
        if (file != null) {
          Navigator.push(
            context,
            HeroRoute(
              builder: (_) => PhotoDetails(
                imageInfoModel: imageInfoModel,
              ),
            ),
          );
        } else {
          Utils.showSnackBar(context, "Photo is not ready! Please wait!");
        }
      },
      child: Hero(
        tag: imageInfoModel.downloadUrl!,
        child: Container(
          height: 70,
          width: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60), color: appBarColor),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: CachedNetworkImage(
                imageUrl: imageInfoModel.downloadUrl!,
                placeholder: (_, __) => const Icon(
                      CupertinoIcons.photo,
                      size: 50,
                    ),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
