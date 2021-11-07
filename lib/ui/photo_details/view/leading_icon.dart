import 'package:flutter/material.dart';
import 'package:ml_gallery/extensions.dart';
import 'package:ml_gallery/utils/constants.dart';

class LeadingWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;
  final bool showNeumorphism;
  const LeadingWidget({
    Key? key,
    required this.icon,
    this.onTap,
    this.showNeumorphism = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return showNeumorphism ? child().addNeumorphism() : child();
  }

  GestureDetector child() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: appBarColor,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 40,
        width: 40,
        child: Center(
          child: Icon(
            icon,
            color: kPrimarySwatch,
          ),
        ),
      ),
    );
  }
}
