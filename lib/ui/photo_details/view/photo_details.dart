import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ml_gallery/ui/home/model/image_info_model.dart';
import 'package:ml_gallery/ui/photo_details/controller/photo_details_controller.dart';
import 'package:ml_gallery/ui/photo_details/view/full_screen_photo.dart';
import 'package:ml_gallery/ui/photo_details/view/related_photos.dart';
import 'package:ml_gallery/ui/ui_helper/ml_text.dart';
import 'package:ml_gallery/utils/constants.dart';
import 'package:ml_gallery/extensions.dart';
import 'package:ml_gallery/utils/hero_route.dart';
import 'package:ml_gallery/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class PhotoDetails extends StatefulWidget {
  final ImageInfoModel imageInfoModel;
  const PhotoDetails({Key? key, required this.imageInfoModel})
      : super(key: key);

  @override
  _PhotoDetailsState createState() => _PhotoDetailsState();
}

class _PhotoDetailsState extends State<PhotoDetails> {
  PhotoDetailsController photoDetailsController = PhotoDetailsController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        foregroundColor: scaffoldColor,
        elevation: 0,
        leading: Container(),
        leadingWidth: 0,
        toolbarHeight: 80,
        title: leadingWidget(() => Navigator.pop(context), Icons.arrow_back),
        actions: [actions()],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            imageCard(widget.imageInfoModel.downloadUrl!),
            author(),
            RelatedPhotos(
              key: Key(widget.imageInfoModel.url!),
              urlId: widget.imageInfoModel.url!.getUrlId(),
            ),
          ],
        ),
      ),
    );
  }

  Row actions() {
    return Row(
      children: [
        leadingWidget(() {
          photoDetailsController.share(widget.imageInfoModel.downloadUrl!);
        }, Icons.share),
        const SizedBox(
          width: 15,
        ),
        leadingWidget(savePhoto, Icons.download),
        const SizedBox(
          width: 15,
        ),
        leadingWidget(openImage, Icons.fullscreen),
        const SizedBox(
          width: 16,
        ),
      ],
    );
  }

  Padding author() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const MlText(text: "Author: "),
          const SizedBox(
            width: 16,
          ),
          MlText(
            text: widget.imageInfoModel.author ?? "",
            fontFamily: fontName,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            textDecoration: TextDecoration.underline,
            onTap: () {
              launch(widget.imageInfoModel.url!);
            },
          ),
        ],
      ),
    );
  }

  Widget leadingWidget(VoidCallback? onTap, IconData icon) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: appBarColor,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 40,
        width: 40,
        child: Center(
          child: Icon(
            icon,
            color: kPrimarySwatch,
          ),
        ),
      ).addNeumorphism(),
    );
  }

  Widget imageCard(String url) {
    return Hero(
      tag: url,
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        height: 300,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: appBarColor),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(
              imageUrl: url,
              placeholder: (_, __) => const Icon(
                    CupertinoIcons.photo,
                    size: 60,
                  ),
              fit: BoxFit.fitHeight),
        ),
      ),
    );
  }

  savePhoto() async {
    File? file = await photoDetailsController
        .getFile(widget.imageInfoModel.downloadUrl!);
    if (file == null) {
      Utils.showSnackBar(
          context, "Something went wrong! cannot save the photo!",
          durationInMiliseconds: 2000);
    } else {
      bool save = await photoDetailsController.savePhoto(file);
      Utils.showSnackBar(
          context, save ? "Photo saved!" : "Unable to save the photo!");
    }
  }

  openImage() {
    Navigator.push(
      context,
      HeroRoute(
        builder: (_) =>
            FullScreenPhoto(url: widget.imageInfoModel.downloadUrl!),
      ),
    );
  }
}
