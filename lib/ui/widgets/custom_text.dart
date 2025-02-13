import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  CustomText({super.key, required this.data, this.fontSize, this.fontColor, this.align});

  String data;
  double? fontSize;
  Color? fontColor;
  TextAlign? align;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: align ?? TextAlign.left,
      style: TextStyle(
        fontSize: fontSize ?? 18,
        fontWeight: FontWeight.bold,
        color: fontColor ?? Colors.black,
      ),
    );
  }
}
