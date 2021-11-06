import 'package:flutter/material.dart';
import 'package:ml_gallery/ui/home/view/photo_card.dart';
import 'package:ml_gallery/ui/ui_helper/ml_text.dart';
import 'package:ml_gallery/utils/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              text: "GALLERY",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ],
        ),
      ),
      body: body(),
    );
  }

  Widget body() {
    return GridView.builder(
      itemCount: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (_, i) => const PhotoCard(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 40/70,
        mainAxisSpacing: 7,
        crossAxisSpacing: 10,
      ),
    );
  }
}
