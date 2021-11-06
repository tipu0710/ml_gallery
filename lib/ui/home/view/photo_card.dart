import 'package:flutter/material.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70),
        image: const DecorationImage(
          image: AssetImage("assets/images/test.jpeg"),
          fit: BoxFit.cover
        ),
      ),
    );
  }
}
