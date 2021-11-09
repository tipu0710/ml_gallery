import 'package:flutter/material.dart';
import 'package:ml_gallery/ui/photo_details/view/photo_details.dart';
import 'package:ml_gallery/ui/photo_library/view/photo_library.dart';

class PhotoLibraryTabView extends StatelessWidget {
  const PhotoLibraryTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(flex: 2, child: PhotoLibrary()),
        Expanded(flex: 4, child: Padding(
          padding: EdgeInsets.only(left:16.0),
          child: PhotoDetails(),
        )),
      ],
    );
  }
}
