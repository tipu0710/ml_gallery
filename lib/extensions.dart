import 'package:flutter/material.dart';
import 'package:ml_gallery/utils/constants.dart';

extension ChangeUrl on String {
  changeUrl({int? height, int? width}) {
    String url = this;
    List<String> list = url.split("/");
    return "$baseUrl/id/${list[4]}/${height ?? 300}/${width ?? 200}";
  }

  getPath() {
    String url = this;
    url = url.replaceAll(baseUrl, "");
    url = url.replaceAll(baseUrl, "");
    url = url.replaceFirst(RegExp(r"\?[^]*"), "");
    return url;
  }
}

extension Neumorphism on Widget {
  addNeumorphism({
    double borderRadius = 10.0,
    Offset offset = const Offset(5, 5),
    double blurRadius = 10,
    Color topShadowColor = Colors.white60,
    Color bottomShadowColor = const Color(0x26234395),
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        boxShadow: [
          BoxShadow(
            offset: offset,
            blurRadius: blurRadius,
            color: bottomShadowColor,
          ),
          BoxShadow(
            offset: Offset(-offset.dx, -offset.dx),
            blurRadius: blurRadius,
            color: topShadowColor,
          ),
        ],
      ),
      child: this,
    );
  }
}