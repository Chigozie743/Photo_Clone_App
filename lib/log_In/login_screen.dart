
import 'package:flutter/material.dart';
import 'components/heading_text.dart';
import 'components/info.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});



  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            //colors: GradientColors.warmFlame,
          colors: [Colors.pink, Colors.deepOrange.shade300],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.2, 0.9],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeadText(),
                const Credentials(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
