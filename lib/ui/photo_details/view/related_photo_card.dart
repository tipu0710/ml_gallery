import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ml_gallery/ui/photo_details/model/related_photo_model.dart';
import 'package:ml_gallery/ui/ui_helper/ml_text.dart';
import 'package:ml_gallery/utils/constants.dart';
import 'package:ml_gallery/utils/hero_route.dart';
import 'package:url_launcher/url_launcher.dart';
import 'full_screen_photo.dart';

class RelatedPhotoCard extends StatelessWidget {
  final Results result;
  const RelatedPhotoCard({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(45), topRight: Radius.circular(45)),
      child: Card(
        color: appBarColor,
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    HeroRoute(
                      builder: (_) => FullScreenPhoto(
                        url: result.links!.download!,
                        relatedPhoto: true,
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: result.links!.download!,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        color: appBarColor),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      child: Stack(
                        children: [
                          const Center(
                            child: Icon(
                              CupertinoIcons.photo,
                              size: 50,
                            ),
                          ),
                          Image.network(
                            result.links!.download!,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            author(),
          ],
        ),
      ),
    );
  }

  Widget author() {
    return Row(
      children: [
        Container(
          height: 30,
          width: 30,
          margin: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: scaffoldColor,
            image: DecorationImage(
              image:
                  CachedNetworkImageProvider(result.user!.profileImage!.small!),
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: MlText(
              text: result.user?.name ?? "",
              fontFamily: fontDancingScript,
              fontSize: 16,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w400,
              textOverflow: TextOverflow.ellipsis,
              textDecoration: TextDecoration.underline,
              onTap: () {
                launch(result.user!.links!.html!);
              },
            ),
          ),
        ),
      ],
    );
  }
}
