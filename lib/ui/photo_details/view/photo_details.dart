import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ml_gallery/ui/home/model/image_info_model.dart';
import 'package:ml_gallery/ui/photo_details/controller/photo_details_controller.dart';
import 'package:ml_gallery/utils/constants.dart';
import 'package:ml_gallery/extensions.dart';

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
        title: leadingWidget(() => Navigator.pop(context), Icons.arrow_back),
        actions: [
          Row(
            children: [
              leadingWidget(() {
                photoDetailsController.share(widget.imageInfoModel.downloadUrl!);
              }, Icons.share),
              const SizedBox(
                width: 15,
              ),
              leadingWidget(() {}, Icons.download),
              const SizedBox(
                width: 16,
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            imageCard(widget.imageInfoModel.downloadUrl!),
          ],
        ),
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
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: CachedNetworkImageProvider(url), fit: BoxFit.fitHeight),
        ),
      ),
    );
  }
}
