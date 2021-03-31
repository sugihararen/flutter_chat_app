import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PrimaryTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final bool autofocus;
  final bool obscureText;
  final Function(String) validator;

  PrimaryTextFormField({
    @required this.hintText,
    @required this.textEditingController,
    this.autofocus,
    this.obscureText,
    @required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white54),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: TextStyle(color: Colors.white),
      autofocus: autofocus ?? false,
      obscureText: obscureText ?? false,
      controller: textEditingController,
      validator: (String value) => validator(value),
    );
  }
}
