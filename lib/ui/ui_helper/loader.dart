import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class Loader extends StatelessWidget {
  final double? size;
  const Loader({
    Key? key,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size ?? 150,
      width: size ?? 150,
      child: const RiveAnimation.asset("assets/anim/ml_gallery_loading.riv"),
    );
  }
}