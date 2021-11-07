import 'package:flutter/material.dart';
import 'package:ml_gallery/ui/home/view/photo_library.dart';
import 'package:ml_gallery/ui/ui_helper/ml_text.dart';
import 'package:ml_gallery/utils/constants.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        foregroundColor: scaffoldColor,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: "logo",
              child: Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 25,
                  width: 25,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const MlText(
              text: "Gallery",
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontFamily: fontName,
            ),
          ],
        ),
      ),
      body: const PhotoLibrary(),
    );
  }
}
