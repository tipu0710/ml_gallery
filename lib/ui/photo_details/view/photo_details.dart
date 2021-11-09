import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ml_gallery/service/providers/photo_model_providers.dart';
import 'package:ml_gallery/ui/home/model/image_info_model.dart';
import 'package:ml_gallery/ui/photo_details/controller/photo_details_controller.dart';
import 'package:ml_gallery/ui/photo_details/view/related_photos.dart';
import 'package:ml_gallery/ui/ui_helper/ml_text.dart';
import 'package:ml_gallery/utils/constants.dart';
import 'package:ml_gallery/extensions.dart';
import 'package:ml_gallery/utils/responsive.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'leading_icon.dart';

class PhotoDetails extends StatefulWidget {
  const PhotoDetails({Key? key}) : super(key: key);

  @override
  _PhotoDetailsState createState() => _PhotoDetailsState();
}

class _PhotoDetailsState extends State<PhotoDetails> {
  PhotoDetailsController photoDetailsController = PhotoDetailsController();
  ImageInfoModel? imageInfoModel;

  bool? isPhone;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      isPhone = MediaQuery.of(context).size.width < 650;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if(isPhone!=null && isPhone! && Responsive.isTablet(context)){
        Navigator.pop(context);
      }
    });
    return Scaffold(
      appBar: Responsive.isMobile(context)
          ? AppBar(
              backgroundColor: scaffoldColor,
              foregroundColor: scaffoldColor,
              elevation: 0,
              leading: Container(),
              leadingWidth: 0,
              toolbarHeight: 80,
              title: Align(
                  alignment: Alignment.centerLeft,
                  child: LeadingWidget(
                    onTap: () => Navigator.pop(context),
                    icon: Icons.arrow_back,
                  )),
              actions: [actions()],
            )
          : null,
      body: Consumer<PhotoModelProviders>(
        builder: (_, photoModelProvider, __) {
          if (photoModelProvider.imageInfoModel != null) {
            imageInfoModel = photoModelProvider.imageInfoModel!;
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  imageCard(imageInfoModel!.downloadUrl!),
                  if (Responsive.isTablet(context))
                    Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: actions()),
                  author(),
                  RelatedPhotos(
                    key: Key(imageInfoModel!.url!),
                    urlId: photoModelProvider.imageInfoModel!.url!.getUrlId(),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: MlText(text: "Select an image", fontSize: 30,),);
          }
        },
      ),
    );
  }

  Row actions() {
    return Row(
      children: [
        LeadingWidget(
            onTap: () {
              photoDetailsController.share(
                  imageInfoModel!.downloadUrl!, context);
            },
            icon: Icons.share),
        const SizedBox(
          width: 15,
        ),
        LeadingWidget(
            onTap: () {
              photoDetailsController.savePhoto(
                  context, imageInfoModel!.downloadUrl!);
            },
            icon: Icons.download),
        const SizedBox(
          width: 15,
        ),
        LeadingWidget(
            onTap: () {
              photoDetailsController.openImage(
                  context, imageInfoModel!.downloadUrl!);
            },
            icon: Icons.fullscreen),
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
            width: 10,
          ),
          MlText(
            text: imageInfoModel!.author ?? "",
            fontFamily: fontDancingScript,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            textDecoration: TextDecoration.underline,
            onTap: () {
              launch(imageInfoModel!.url!);
            },
          ),
        ],
      ),
    );
  }

  Widget imageCard(String url) {
    return Hero(
      tag: url,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: appBarColor),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(
              imageUrl: url,
              placeholder: (_, __) => Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: appBarColor),
                    child: const Icon(
                      CupertinoIcons.photo,
                      size: 60,
                    ),
                  ),
              fit: BoxFit.fitHeight),
        ),
      ),
    );
  }
}
