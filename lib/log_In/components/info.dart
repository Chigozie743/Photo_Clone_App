import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_sharing_clone_app/account_check/account_check.dart';
import 'package:photo_sharing_clone_app/forget_password/forget_password.dart';
import 'package:photo_sharing_clone_app/home_screen/home_screen.dart';
import 'package:photo_sharing_clone_app/sign_up/sign_up_screen.dart';
import 'package:photo_sharing_clone_app/widgets/button_square.dart';
import 'package:photo_sharing_clone_app/widgets/input_fields.dart';


class Credentials extends StatefulWidget {
  const Credentials({Key? key}) : super(key: key);

  @override
  State<Credentials> createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailTextController = TextEditingController(text: '');
  final TextEditingController _passTextController = TextEditingController(text: '');


  logIn() async {
    try{
      _auth.signInWithEmailAndPassword(
          email: _emailTextController.text.trim().toLowerCase(),
          password: _passTextController.text.trim()
      );
      //if(!mounted) return;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen())
      );
    }
    catch(error)
    {
      Fluttertoast.showToast(msg: error.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 100,
              backgroundImage: const AssetImage(
                "images/logo1.png",
              ),
              backgroundColor: Colors.orange.shade800,
            ),
          ),
          const SizedBox(height: 15.0,),
          InputField(
            hintText: "Enter Email",
            icon: Icons.email_rounded,
            obscureText: false,
            textEditingController: _emailTextController,
          ),
          const SizedBox(height: 15.0,),
          InputField(
            hintText: "Enter Password",
            icon: Icons.lock,
            obscureText: true,
            textEditingController: _passTextController,
          ),
          const SizedBox(height: 15.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => ForgetPasswordScreen()
                      ));
                },
                child: const Text(
                  "Forget Password",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 17.0,
                  ),
                ),
              ),
            ],
          ),
          ButtonSquare(
            text: "Login",
            colors1: Colors.red,
            colors2: Colors.redAccent,

            press: () async{
              await logIn();
            },
          ),
          AccountCheck(
            login: true,
            press: (){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => SignUpScreen()
                  ));
            },
          ),
        ],
      ),
    );
  }
}

