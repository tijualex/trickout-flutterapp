import 'package:flutter/material.dart';
import 'package:trickout/firebase_options.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
  // Error handling
  try {
    await Firebase.initializeApp(
       options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch(e) {
    print('Error initializing Firebase $e');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      // routes: {
      //   '/login': (context) => LoginPage(),
      //   '/signup': (context) => SignUpPage(),
      // },
      home: LoginPage(),
    );

  }

}