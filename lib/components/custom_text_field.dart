import 'package:civil_home_plan/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final Function onchanged;
  final Function validator;
  final TextInputType inputType;

  const CustomTextField(
      {Key key, this.label, this.onchanged, this.validator, this.inputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelStyle: TextStyle(color: BLACK_COLOR, fontWeight: FontWeight.bold),
        labelText: label,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(color: BLACK_COLOR),
        ),
      ),
      onChanged: onchanged,
      validator: validator,
      keyboardType: inputType,
    );
  }
}
