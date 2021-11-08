import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ml_gallery/ui/photo_details/controller/related_photo_controller.dart';
import 'package:ml_gallery/ui/photo_details/model/related_photo_model.dart';
import 'package:ml_gallery/ui/photo_details/view/related_photo_card.dart';
import 'package:ml_gallery/ui/ui_helper/loader.dart';
import 'package:ml_gallery/ui/ui_helper/ml_text.dart';

class RelatedPhotos extends StatelessWidget {
  final String urlId;
  const RelatedPhotos({required Key key, required this.urlId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RealtedPhotoModel>(
        future: RelatedPhotoController().getModel(urlId),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return body(snapshot.data!);
          } else {
            return const Loader();
          }
        });
  }

  Widget body(RealtedPhotoModel realtedPhotoModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: MlText(text: "Related photos: "),
        ),
        GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          shrinkWrap: true,
          childAspectRatio: 40 / 50,
          children: [
            for (var i = 0; i < (realtedPhotoModel.results?.length ?? 0); i++)
              RelatedPhotoCard(result: realtedPhotoModel.results![i])
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
