import 'package:flutter/material.dart';
import 'package:ml_gallery/extensions.dart';
import 'package:ml_gallery/ui/photo_details/controller/photo_details_controller.dart';
import 'package:ml_gallery/ui/photo_details/view/leading_icon.dart';
import 'package:ml_gallery/ui/ui_helper/loader.dart';

class FullScreenPhoto extends StatelessWidget {
  final String url;
  final bool relatedPhoto;
  const FullScreenPhoto(
      {Key? key, required this.url, this.relatedPhoto = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    PhotoDetailsController photoDetailsController = PhotoDetailsController();
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.85),
      body: SafeArea(
        child: Stack(
          children: [
            InteractiveViewer(
              maxScale: 4,
              child: Center(
                child: Hero(
                  tag: url.changeUrl(),
                  child: Image.network(
                    url,
                    loadingBuilder: (_, __, ___) => const Loader(),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: LeadingWidget(
                      icon: Icons.arrow_back,
                      onTap: () => Navigator.pop(context),
                      showNeumorphism: false,
                    ),
                  ),
                  if (relatedPhoto)
                    Row(
                      children: [
                        Row(
                          children: [
                            LeadingWidget(
                                onTap: () {
                                  photoDetailsController.share(url);
                                },
                                showNeumorphism: false,
                                icon: Icons.share),
                            const SizedBox(
                              width: 15,
                            ),
                            LeadingWidget(
                                onTap: () {
                                  photoDetailsController.savePhoto(
                                      context, url);
                                },
                                showNeumorphism: false,
                                icon: Icons.download),
                            const SizedBox(
                              width: 16,
                            ),
                          ],
                        )
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
