import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:photo_sharing_clone_app/home_screen/home_screen.dart';

import 'log_In/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot)
        {
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return const MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  body: Center(
                    child: Center(
                      child: Text(
                        "Welcome to PhotoSharing Clone App"
                      ),
                    ),
                  ),
                ),
              );
            }
          else if(snapshot.hasError)
            {
              return const MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  body: Center(
                    child: Center(
                      child: Text(
                          "An error occurred, Please wait..."
                      ),
                    ),
                  ),
                ),
              );
            }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Flutter PhotoSharing Clone App",
            home: FirebaseAuth.instance.currentUser == null ? LoginScreen() : HomeScreen(),
          );
        }
    );
  }
}


