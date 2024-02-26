import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart' as file_picker;
import '/pages/user_profile.dart';

class NeckPattern extends StatefulWidget {
  @override
  _NeckPatternState createState() => _NeckPatternState();
}

class _NeckPatternState extends State<NeckPattern> {
  // Index for the selected tab
  int _currentIndex = 0;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dressTypeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  file_picker.File? _pickedImage;
  final TextEditingController descriptionController = TextEditingController();

  // creation of a new neckpattern
  // Function to handle form submission
  void addNeckPattern() async {
    String name = nameController.text;
    String dressType = dressTypeController.text;
    double price = double.tryParse(priceController.text) ?? 0.0;
    String image = _pickedImage?.name ?? '';
    String description = descriptionController.text;

    // Reference to the dress_types collection
    CollectionReference dressTypesCollection =
        FirebaseFirestore.instance.collection('dress_types');

    // Check if the dress type already exists, if not, add it
    QuerySnapshot dressTypeQuery =
        await dressTypesCollection.where('name', isEqualTo: dressType).get();
    if (dressTypeQuery.docs.isEmpty) {
      await dressTypesCollection.add({'name': dressType});
    }

    // Get the reference to the dress_type document
    DocumentReference dressTypeRef = dressTypesCollection.doc(dressType);

    // Store data in the neckpattern collection
    await FirebaseFirestore.instance.collection('neckpattern').add({
      'name': name,
      'dresstype': dressTypeRef,
      'price': price,
      'image': image,
      'description': description,
    });

    // Clear the form fields after submission
    nameController.clear();
    dressTypeController.clear();
    priceController.clear();
    descriptionController.clear();
    setState(() {
      _pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24.0),
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Handle home option
                print('Home option selected');
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Handle profile option
                navigateToUserProfilePage(context);
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.blue, // Customize the indicator color
            tabs: [
              Tab(text: ' ALL NECK PATTERNS'),
              Tab(text: 'ADD NEW NECKPATTERN'),
            ],
            onTap: (index) {
              // Handle tab switch
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Let's order fresh items for you
            const SizedBox(height: 24),
            // categories -> horizontal listview
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: NeckPatternList(),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: buildAddNeckPatternForm(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddNeckPatternForm() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add New Neck Pattern',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextFormField(
            controller: dressTypeController,
            decoration: InputDecoration(labelText: 'Dress Type'),
          ),
          TextFormField(
            controller: priceController,
            decoration: InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Pick an Image'),
          ),
          _pickedImage != null
              ? Text(
                  'Selected Image: ${_pickedImage!.name}',
                  style: TextStyle(fontSize: 16),
                )
              : Container(),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
            maxLines: 3,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: addNeckPattern,
            child: Text('Add Neck Pattern'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedImage = await file_picker.FilePicker.platform.pickFiles(type: file_picker.FileType.image);

    if (pickedImage != null && pickedImage.files.isNotEmpty) {
      setState(() {
        _pickedImage = pickedImage.files.first;
      });
    }
  }

  void navigateToUserProfilePage(BuildContext context) {
    // Get the currently authenticated user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Navigate to UserProfilePage with the user ID
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return UserProfilePage(uid: user.uid);
        }),
      );
    } else {
      // print('No user is currently signed in.');
    }
  }
}

class NeckPatternList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Reference to the neckpattern collection
    CollectionReference neckPatternCollection =
        FirebaseFirestore.instance.collection('neckpattern');
    return Container(
      alignment: Alignment.center,
      child: StreamBuilder<QuerySnapshot>(
        stream: neckPatternCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          // Extract documents from the snapshot
          List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

          if (documents.isEmpty) {
            return Text('No Neck Patterns available.');
          }

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              // Use the CustomTile widget to display each item
              return CustomTile(
                documents[index]['name'],
                Colors.blue,
              ); // Assuming 'name' is the field in your neckpattern collection
            },
          );
        },
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  final String title;
  final Color color;

  CustomTile(this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: 500,
      height: 100, // Fixed width
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
