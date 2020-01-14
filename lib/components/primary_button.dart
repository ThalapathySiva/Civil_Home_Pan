import 'package:civil_home_plan/constants/colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function onpressed;

  const PrimaryButton({Key key, this.text, this.onpressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
      child: RaisedButton(
        color: BLUE_COLOR,
        onPressed: onpressed,
        child: Text(
          text,
          style: TextStyle(
              color: WHITE_COLOR, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
