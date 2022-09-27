import 'package:flutter/material.dart';

class HeadText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.05),
          const Center(
            child: Text(
              "Forget Password",
              style: TextStyle(
                fontSize: 60.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "Signatra",
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          const Center(
            child: Text(
              "Reset Here",
              style: TextStyle(
                fontSize: 35.0,
                color: Colors.white30,
                fontWeight: FontWeight.bold,
                fontFamily: "Bebas",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
