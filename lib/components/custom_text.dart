import 'package:civil_home_plan/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final bool isBold;
  final Color color;

  const CustomText(
      {Key key, this.text, this.size, this.isBold = false, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size,
          fontWeight: isBold ? FontWeight.bold : null,
          color: color == null ? BLACK_COLOR : color),
    );
  }
}
