import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserProfilePage extends StatefulWidget {
  final String uid;

  UserProfilePage({required this.uid});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Load existing user profile data if available
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('userprofile')
          .doc(widget.uid)
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

        setState(() {
          _firstNameController.text = userData['firstName'] ?? '';
          _lastNameController.text = userData['lastName'] ?? '';
          _phoneNumberController.text = userData['phoneNumber'] ?? '';
          // You may need to modify the logic for loading the image URL
          // based on your data structure
          String imageUrl = userData['imageUrl'] ?? '';
          if (imageUrl.isNotEmpty) {
            _image = File(imageUrl);
          }
        });
      }
    } catch (error) {
      print('Error loading user profile: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _pickImage();
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                      ? FileImage(_image!) as ImageProvider<Object>
                      : AssetImage('assets/placeholder_image.png'),
                ),
              ),
              SizedBox(height: 10),
              Text('Tap to change profile picture'),
              SizedBox(height: 20),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  // You can add more specific phone number validation if needed
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    saveUserProfile();
                  }
                },
                child: Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
Future<String> _pickImage() async {

  final pickedFile = await picker.getImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    return pickedFile.path;
  } 

  // Default asset path
  return 'assets/default_image.png'; 
}

  Future<void> saveUserProfile() async {
    try {
      String firstName = _firstNameController.text;
      String lastName = _lastNameController.text;
      String phoneNumber = _phoneNumberController.text;

      // Upload image to Firebase Storage
      String imageUrl = await _pickImage();

      // Save user profile to Firestore
      await FirebaseFirestore.instance.collection('userprofile').doc(widget.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'imageUrl': imageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User profile saved successfully'),
        ),
      );
    } catch (error) {
      print('Error saving user profile: $error');
    }
  }

}


