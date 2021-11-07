import 'package:flutter/material.dart';
import 'package:ml_gallery/utils/constants.dart';

class MlText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final EdgeInsets? margin;
  final FontWeight? fontWeight;
  final TextOverflow? textOverflow;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  final int? maxLine;
  final double? textHeight;
  final String? fontFamily;
  final VoidCallback? onTap;
  const MlText({
    Key? key,
    required this.text,
    this.margin,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textOverflow,
    this.textDecoration,
    this.maxLine,
    this.textAlign,
    this.textHeight, this.fontFamily, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        textAlign: textAlign ?? TextAlign.center,
        overflow: textOverflow,
        maxLines: maxLine,
        style: TextStyle(
            color: color ?? kPrimaryColor,
            fontFamily: fontFamily?? fontLibreBaskerville,
            fontSize: fontSize ?? 16,
            letterSpacing: 0,
            fontWeight: fontWeight ?? FontWeight.w500,
            decoration: textDecoration,
            height: textHeight ?? 1),
      ),
    );
  }
}
