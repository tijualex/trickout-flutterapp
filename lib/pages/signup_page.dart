// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:trickout/components/my_button.dart';
// import 'package:trickout/components/my_textfield.dart';
// import 'package:trickout/components/square_tile.dart';

// class SignUpPage extends StatefulWidget {

//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

//   final TextEditingController firstnameController = TextEditingController();

//   final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

//   final TextEditingController lastnameController = TextEditingController();

//   final TextEditingController emailController = TextEditingController();

//   final TextEditingController phoneController = TextEditingController();

//   final TextEditingController passwordController = TextEditingController();

//   final TextEditingController confirmpasswordController = TextEditingController();

//   String? validateFirstName(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your first name';
//     }
//     return null;
//   }

//   String? validateLastName(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your last name';
//     }
//     return null;
//   }

//   String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your email';
//     } else if (!value.contains('@')) {
//       return 'Please enter a valid email address';
//     }
//     return null;
//   }

//   String? validatePhone(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your phone number';
//     }
//     return null;
//   }

//   String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter a password';
//     } else if (value.length < 8) {
//       return 'Password should be at least 8 characters long';
//     } else if (!RegExp(r'(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])').hasMatch(value)) {
//       return 'Password should contain at least one uppercase letter, one lowercase letter, one digit, and one special character';
//     }
//     return null;
//   }

//   String? validateConfirmPassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please confirm your password';
//     } else if (value != passwordController.text) {
//       return 'Passwords do not match';
//     }
//     return null;
//   }

//   void _handleSignIn() async {
//     try {
//       await _googleSignIn.signIn();
//       // Add your sign-up logic here using _googleSignIn.currentUser
//       print('Google Sign In successful');
//     } catch (error) {
//       print('Error signing in with Google: $error');
//     }
//   }

//   void navigateToLogInPage(BuildContext context) {
//     Navigator.pop(context); // Use pop to navigate back to the login page
//   }

//   void signUserUp()async {
//     if (signUpFormKey.currentState!.validate()){
      
      
//         if (passwordController == confirmpasswordController) {
//           //creating user with email and pssword
//           await FirebaseAuth.instance
//               .createUserWithEmailAndPassword(
//             email: emailController.toString(),
//             password: passwordController.toString(),
//           )
//               .whenComplete(() {
//             setState(() {
//               signUpFormKey.currentState!.reset();
//             });
//           });
//         }}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Center(
//             child: Form(
//               key: signUpFormKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 50),
              
//                   const Icon(
//                     Icons.lock,
//                     size: 100,
//                   ),
              
//                   const SizedBox(height: 50),
              
//                   Text(
//                     'sign up',
//                     style: TextStyle(
//                       color: Colors.grey[700],
//                       fontSize: 16,
//                     ),
//                   ),
              
//                   const SizedBox(height: 25),
              
//                    MyTextField(
//                       controller: firstnameController,
//                       hintText: 'First Name',
//                       obscureText: false,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//               return 'Please enter a valid first name';
//                         }
//                         return null;
//                       },
//                     ),
              
//                     MyTextField(
//                       controller: lastnameController,
//                       hintText: 'Last Name',
//                       obscureText: false,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//               return 'Please enter a valid last name';
//                         }
//                         return null;
//                       },
//                     ),
              
//                     MyTextField(
//                       controller: emailController,
//                       hintText: 'Email',
//                       obscureText: false,
//                       validator: (value) {
//                         if (value == null || value.isEmpty || !value.contains('@')) {
//               return 'Please enter a valid email address';
//                         }
//                         return null;
//                       },
//                     ),
              
//                     MyTextField(
//                       controller: phoneController,
//                       hintText: 'Phone Number',
//                       obscureText: false,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//               return 'Please enter a valid phone number';
//                         }
//                         return null;
//                       },
//                     ),
              
//                     MyTextField(
//                       controller: passwordController,
//                       hintText: 'Password',
//                       obscureText: true,
//                       validator: validatePassword,
//                     ),
              
//                     MyTextField(
//                       controller: confirmpasswordController,
//                       hintText: 'Confirm Password',
//                       obscureText: true,
//                       validator: validateConfirmPassword,
//                     ),
              
//                   // Repeat the MyTextField for other fields
              
//                   SizedBox(height: 32),
//                   ElevatedButton(
//                     onPressed: _handleSignIn,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset('images/google_logo.png', height: 24.0),
//                         SizedBox(width: 16),
//                         Text('Sign Up with Google'),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   MyButton(
//                     //formKey: signUpFormKey,
//                     onTap: signUserUp,
//                   ),
//                   SizedBox(height: 16),
//                   GestureDetector(
//                     onTap: () {
//                       navigateToLogInPage(context);
//                     },
//                     child: Text(
//                       'Already have an account? Log In',
//                       style: TextStyle(color: Colors.blue),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }}
  
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }







///ode 2
///


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:login/commons/button.dart';
// import 'package:login/commons/textfield.dart';

// class SignUpPage extends StatefulWidget {
//   SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   // final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

//   final TextEditingController firstnameController = TextEditingController();

//   final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

//   final TextEditingController lastnameController = TextEditingController();

//   final TextEditingController emailController = TextEditingController();

//   final TextEditingController phoneController = TextEditingController();

//   final TextEditingController passwordController = TextEditingController();

//   final TextEditingController confirmpasswordController =
//       TextEditingController();

//   String? validateFirstName(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your first name';
//     }
//     return null;
//   }

//   String? validateLastName(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your last name';
//     }
//     return null;
//   }

//   String? validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your email';
//     } else if (!value.contains('@')) {
//       return 'Please enter a valid email address';
//     }
//     return null;
//   }

//   String? validatePhone(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter your phone number';
//     }
//     return null;
//   }

//   String? validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter a password';
//     } else if (value.length < 8) {
//       return 'Password should be at least 8 characters long';
//     } else if (!RegExp(r'(?=.[A-Z])(?=.[a-z])(?=.\d)(?=.[@$!%*?&])')
//         .hasMatch(value)) {
//       return 'Password should contain at least one uppercase letter, one lowercase letter, one digit, and one special character';
//     }
//     return null;
//   }

//   String? validateConfirmPassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please confirm your password';
//     } else if (value != passwordController.text) {
//       return 'Passwords do not match';
//     }
//     return null;
//   }

//   // void _handleSignIn() async {
//   //   try {
//   //     await _googleSignIn.signIn();
//   //     // Add your sign-up logic here using _googleSignIn.currentUser
//   //     print('Google Sign In successful');
//   //   } catch (error) {
//   //     print('Error signing in with Google: $error');
//   //   }
//   // }

//   void navigateToLogInPage(BuildContext context) {
//     Navigator.pop(context); // Use pop to navigate back to the login page
//   }

//   void signUserUp() async {
//     if (signUpFormKey.currentState!.validate()) {
//       if (passwordController == confirmpasswordController) {
//         //creating user with email and pssword
//         await FirebaseAuth.instance
//             .createUserWithEmailAndPassword(
//           email: emailController.toString(),
//           password: passwordController.toString(),
//         )
//             .whenComplete(() {
//           setState(() {
//             signUpFormKey.currentState!.reset();
//           });
//         });
//       }
//     }

//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//         backgroundColor: Colors.grey[300],
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Center(
//               child: Form(
//                 key: signUpFormKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 50),

//                     const Icon(
//                       Icons.lock,
//                       size: 100,
//                     ),

//                     const SizedBox(height: 50),

//                     Text(
//                       'sign up',
//                       style: TextStyle(
//                         color: Colors.grey[700],
//                         fontSize: 16,
//                       ),
//                     ),

//                     const SizedBox(height: 25),

//                     MyTextField(
//                       controller: firstnameController,
//                       hintText: 'First Name',
//                       obscureText: false,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a valid first name';
//                         }
//                         return null;
//                       },
//                     ),

//                     MyTextField(
//                       controller: lastnameController,
//                       hintText: 'Last Name',
//                       obscureText: false,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a valid last name';
//                         }
//                         return null;
//                       },
//                     ),

//                     MyTextField(
//                       controller: emailController,
//                       hintText: 'Email',
//                       obscureText: false,
//                       validator: (value) {
//                         if (value == null ||
//                             value.isEmpty ||
//                             !value.contains('@')) {
//                           return 'Please enter a valid email address';
//                         }
//                         return null;
//                       },
//                     ),

//                     MyTextField(
//                       controller: phoneController,
//                       hintText: 'Phone Number',
//                       obscureText: false,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a valid phone number';
//                         }
//                         return null;
//                       },
//                     ),

//                     MyTextField(
//                       controller: passwordController,
//                       hintText: 'Password',
//                       obscureText: true,
//                       validator: validatePassword,
//                     ),

//                     MyTextField(
//                       controller: confirmpasswordController,
//                       hintText: 'Confirm Password',
//                       obscureText: true,
//                       validator: validateConfirmPassword,
//                     ),

//                     // Repeat the MyTextField for other fields

//                     SizedBox(height: 32),
//                     // ElevatedButton(
//                     //   //onPressed: _handleSignIn,
//                     //   child: Row(
//                     //     mainAxisAlignment: MainAxisAlignment.center,
//                     //     children: [
//                     //       //Image.asset('images/google_logo.png', height: 24.0),
//                     //       SizedBox(width: 16),
//                     //       Text('Sign Up with Google'),
//                     //     ],
//                     //   ),
//                     // ),
//                     SizedBox(height: 16),
//                     MyButton(
//                       //formKey: signUpFormKey,
//                       onTap: signUserUp,
//                     ),
//                     SizedBox(height: 16),
//                     GestureDetector(
//                       onTap: () {
//                         navigateToLogInPage(context);
//                       },
//                       child: Text(
//                         'Already have an account? Log In',
//                         style: TextStyle(color: Colors.blue),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trickout/pages/index.dart';
import 'package:trickout/pages/login_page.dart';
import 'package:trickout/service/auth_service.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  late String Cpassword;

  //sign vendor in method
  void signUserUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
        if (password == Cpassword) {
          //creating user with email and pssword
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
              .whenComplete(() {
            setState(() {
              _formKey.currentState!.reset();
            });
          });

          Navigator.pop(context);
        } else {
          //show error
          Navigator.pop(context);
          PasswordMessage();
        }
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        //wrong email
        if (e.code == 'user-not-found') {
          print('No user found!!!');
          //show error to userr
          wrongEmailMessage();
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          userExistMessage();
        } else if (e.code == 'wrong-password') {
          print('Wrong password');
          //error message
          wrongPasswordMessage();
        }
      }
    }
    // ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Congratulation Account have been Created!!')));
  }

  //wrong email popup
  void wrongEmailMessage() {
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         title: Text('Incorrect Email'),
    //       );
    //     });
  }

  void wrongPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: Border.all(),
            title: Text('Incorrect password'),
          );
        });
  }

  void userExistMessage() {
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         shape: Border.all(),
    //         title: Text('User already exists!!'),
    //       );
    //     });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('User Already Exists!!')));
  }

  void PasswordMessage() {
    //showDialog(
    // context: context,
    // builder: (context) {
    //   return AlertDialog(
    //     // shape: Border.all(),
    //     title: Text('Password do not match!!'),
    //   );
    // });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Password do not Match!!'),
      ),
    );
  }

  void signInWithGoogle() async {
    try {
      await AuthService().signInWithGoogle();
      // Navigate to the next screen after successful Google sign-in.
      print('successfull');
      // Example:
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PageOne()));
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Let's create an account!!!",
                    style: TextStyle(
                      color: Color.fromARGB(255, 8, 8, 8),
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(
                    height: 25,
                  ),

                  //usrname text field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please email cannot be empty';
                        } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return "Please Enter a Valid Email";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                          hintText: 'Email',
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // password textfield
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please password must not be empty!!';
                        } else if (value.length < 6) {
                          return 'please enter a password of atleast 6 character!';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //confirm password text filrd
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      //controller: confirmpasswordcontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please Password must not be empty!';
                        } else if (value.length < 6) {
                          return 'please enter a password of atleast 6 character!';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        Cpassword = value;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //button for sign up
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: GestureDetector(
                      onTap: () {
                        return signUserUp();
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                        ),
                        Text('or continue with'),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton.extended(
                    icon: Icon(
                      Icons.security_rounded,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.black,
                    onPressed: () {
                      signInWithGoogle();
                    },
                    label: Text(
                      'Sign In with Google',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Login? '),
                        SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginPage();
                            }));
                          },
                          child: Text(
                            'Login Now',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}