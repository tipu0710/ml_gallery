import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ml_gallery/utils/constants.dart';

class FullScreenPhoto extends StatelessWidget {
  final String url;
  const FullScreenPhoto({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.85),
      body: SafeArea(
        child: Stack(
          children: [
            InteractiveViewer(
              maxScale: 4,
              child: Center(
                child: Hero(
                  tag: url,
                  child: CachedNetworkImage(imageUrl: url),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: leadingWidget(context),
            ),
          ],
        ),
      ),
    );
  }

    Widget leadingWidget(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Navigator.pop(context),
      child: Container(
        decoration: BoxDecoration(
          color: appBarColor.withOpacity(.5),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 40,
        width: 40,
        margin: const EdgeInsets.only(right: 16, top: 10),
        child: const Center(
          child: Icon(
            Icons.close,
            color: kPrimarySwatch,
          ),
        ),
      ),
    );
  }
}
