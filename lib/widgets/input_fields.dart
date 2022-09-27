import 'package:flutter/material.dart';

import 'text_field_container.dart';

class InputField extends StatelessWidget {

  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController textEditingController;

  InputField({
    required this.hintText,
    required this.icon,
    required this.obscureText,
    required this.textEditingController,
});

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        cursorColor: Colors.white,
        obscureText: obscureText,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          helperStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18.0
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.white,
            size: 20.0,
          ),
          border: InputBorder.none
        ),
      ),
    );
  }
}
