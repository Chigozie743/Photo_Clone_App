import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {

  final Widget child;

  TextFieldContainer({
    required this.child,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.redAccent, Colors.red]
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            offset: Offset(-2, -2),
            spreadRadius: 1,
            blurRadius: 4,
            color: Colors.red
          ),
          BoxShadow(
              offset: Offset(-2, -2),
              spreadRadius: 1,
              blurRadius: 4,
              color: Colors.redAccent,
          ),
        ],
      ),
      child: child,
    );
  }
}
