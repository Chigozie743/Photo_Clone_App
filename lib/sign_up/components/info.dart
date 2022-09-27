// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_sharing_clone_app/account_check/account_check.dart';
import 'package:photo_sharing_clone_app/home_screen/home_screen.dart';
import 'package:photo_sharing_clone_app/log_In/login_screen.dart';
import 'package:photo_sharing_clone_app/widgets/button_square.dart';
import 'package:photo_sharing_clone_app/widgets/input_fields.dart';

class Credentials extends StatefulWidget {
  const Credentials({super.key});



  @override
  State<Credentials> createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _fullNameController = TextEditingController(text: "");
  final TextEditingController _emailTextController = TextEditingController(text: "");
  final TextEditingController _passTextController = TextEditingController(text: "");
  final TextEditingController _phoneNumController = TextEditingController(text: "");

  File? imageFile;
  String? imageUrl;

  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Please choose an option"
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  _getFromCamera();
                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.camera,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      "Camera",
                      style: TextStyle(
                        color: Colors.red
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _getFromGallery();
                },
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.image,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      "Gallery",
                      style: TextStyle(
                          color: Colors.red
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  void _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: filePath, maxHeight: 1080, maxWidth: 1080
    );
    if(croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  getImage() async {
    final ref = FirebaseStorage.instance.ref().child(
        "userImages"
    ).child('${DateTime.now()}.jpg');
    await ref.putFile(imageFile!);
    imageUrl = await ref.getDownloadURL();
    setState(() {
      debugPrint('imageUrl: $imageUrl');
    });
  }

  Future signUp() async {
    if(imageFile == null){
      Fluttertoast.showToast(msg: "Please select an image");
      return;
    }
    try{
      await _auth.createUserWithEmailAndPassword(
        email: _emailTextController.text.trim().toLowerCase(),
        password: _passTextController.text.trim(),
      ).then((value) {
        final User? user = _auth.currentUser;
        final uid = user!.uid;
        FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set({
          'id': uid,
          'userImage': imageUrl,
          'name': _fullNameController.text,
          'email': _emailTextController.text,
          'phoneNumber': _phoneNumController.text,
          'createAt': Timestamp.now(),
        });
      });

      //if(!mounted) return; // Use mounted to remove the async gap error
      Navigator.canPop(context) ? Navigator.pop(context) : null;
    } catch(error) {
      Fluttertoast.showToast(msg: error.toString());
    }
    //if(!mounted) return;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _showImageDialog();
            },
            child: CircleAvatar(
              radius: 90,
              backgroundImage: imageFile == null
                  ?
                  const AssetImage("images/avatar.png")
                  :
                  Image.file(imageFile!).image
            ),
          ),
          const SizedBox(height: 10.0,),
          InputField(
            hintText: "Enter Username",
            icon: Icons.person,
            obscureText: false,
            textEditingController: _fullNameController,
          ),
          const SizedBox(height: 10.0,),
          InputField(
            hintText: "Enter Email",
            icon: Icons.email_rounded,
            obscureText: false,
            textEditingController: _emailTextController,
          ),
          const SizedBox(height: 10.0,),
          InputField(
            hintText: "Enter Password",
            icon: Icons.lock,
            obscureText: true,
            textEditingController: _passTextController,
          ),
          const SizedBox(height: 10.0,),
          InputField(
            hintText: "Enter Phone Number",
            icon: Icons.phone,
            obscureText: false,
            textEditingController: _phoneNumController,
          ),
          const SizedBox(height: 15.0,),
          ButtonSquare(
            text: "Create Account",
            colors1: Colors.red,
            colors2: Colors.redAccent,

            press: () async {
              await getImage();
              await signUp();

            },
          ),
          AccountCheck(
            login: false,
            press: () async {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen())
              );
            },
          ),
        ],
      ),
    );
  }
}
