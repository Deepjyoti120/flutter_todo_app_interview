import 'package:flutter/material.dart';

class DesignText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final int? maxLines;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final String? fontFamily;
  final TextDecoration? decoration;

  const DesignText(
    this.text, {
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    Key? key,
    this.maxLines,
    this.fontFamily,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize ?? 16,
        color: color,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        decoration: decoration,
      ),
    );
  }
}