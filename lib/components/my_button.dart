import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onTap;
  // GlobalKey<FormState>? formKey; // Make this nullable

  const MyButton({super.key, 
    required this.onTap, 
     // Update this line
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text('Submit'),
    );
  }
}