import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trickout/pages/home_designer.dart';
import 'package:trickout/pages/index.dart';
import 'signup_page.dart'; // Correct import statement for SignUpPage


class LoginPage extends StatelessWidget {
  LoginPage({Key? key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  void signInUser(BuildContext context) async {
  try {
    String email = usernameController.text;
    String password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
    // Check if the user is a designer by querying the Firestore collection
      String uid = userCredential.user?.uid ?? '';
      print("hai");
      print(uid);
      // Successfully signed in, you can access userCredential.user for user details
      print('Successfully signed in with email: $email');

      String useremail = email; 
      String role = await getUserRole(useremail);

      if (role == 'designer') {
        // If the user is a designer, navigate to the designer home screen
        navigateToDesignerHome(context);
      } else {
        // If the user is not a designer, navigate to the regular home screen or another screen
        navigateToPageOne(context);
      }
    } else {
      // Display an error message for empty fields
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter both email and password'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  } on FirebaseAuthException catch (e) {
    // Handle authentication errors
    print('Error signing in: $e');
    String errorMessage = 'Error signing in. Please try again.';

    if (e.code == 'user-not-found') {
      errorMessage = 'No user found with this email.';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'Incorrect password.';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
  void navigateToPageOne(BuildContext context){
    Navigator.push(context,MaterialPageRoute (builder: (context) {
      return  PageOne();
      }));
  } 
  void navigateToDesignerHome(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return DesignerHome();
    }));
  }
  void navigateToSignUpPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return RegistrationPage();
    }));
  }


  Future<String> getUserRole(String email) async {
  print("getuserrole");

  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get();

  if (snapshot.docs.isEmpty) {
    // No matching user
    print("empty");
    return 'default'; 
  }

  DocumentSnapshot doc = snapshot.docs.first;

  String role = doc['role']; // Get role field
  print(role);

  if (role != 'Designer'  && role != 'designer') {
    // Invalid role
    print("user");
    return 'user';
  }

  return role;

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Form(
            key: loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(height: 50),
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Username',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    if (loginFormKey.currentState!.validate()) {
                      signInUser(context);
                    }
                  },
                  child: Text('Sign In'),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // Add Google and Apple sign-in buttons here
                    // SquareTile(imagePath: 'path_to_google_logo.jpg'),
                    SizedBox(width: 25),
                    // SquareTile(imagePath: 'path_to_apple_logo.png')
                  ],
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    navigateToSignUpPage(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
