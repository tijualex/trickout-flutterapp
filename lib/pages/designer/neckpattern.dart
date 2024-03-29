import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import '/pages/user_profile.dart';

class NeckPattern extends StatefulWidget {
  @override
  _NeckPatternState createState() => _NeckPatternState();
}

class _NeckPatternState extends State<NeckPattern> {
  int _currentIndex = 0;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  PickedFile? _pickedImage;
  final TextEditingController detailsController = TextEditingController();
  String selectedDressType = '';
  int selectedDressTypeId =
      1; // Initialize with an empty string or a default value

  late CollectionReference dressTypesCollection;
  late List<Map<String, dynamic>> dressTypesList;

  @override
  void initState() {
    super.initState();
    dressTypesCollection = FirebaseFirestore.instance.collection('dress_type');

    getDressTypes().then((types) {
      setState(() {
        dressTypesList = types;
      });
    });
  }

  void addNeckPattern() async {
    await FirebaseFirestore.instance.collection('neckpattern').add({
      'name': nameController.text,
      'dresstype': selectedDressTypeId,
      'price': double.parse(priceController.text),
      'image': _pickedImage?.path ?? '',
      'details': detailsController.text,
    });

    QuerySnapshot dressTypeQuery = await dressTypesCollection
        .where('name', isEqualTo: selectedDressType)
        .get();
    if (dressTypeQuery.docs.isEmpty) {
      await dressTypesCollection.add({'name': selectedDressType});
    }

    nameController.clear();
    priceController.clear();
    detailsController.clear();
    setState(() {
      _pickedImage = null;
    });
  }

  // Fetch dress types directly from Firestore
  Future<List<Map<String, dynamic>>> getDressTypes() async {
    QuerySnapshot dressTypesSnapshot =
        await FirebaseFirestore.instance.collection('dress_type').get();

    return dressTypesSnapshot.docs
        .map((DocumentSnapshot document) =>
            Map<String, dynamic>.from(document.data() as Map))
        .toList();
  }

  List<DropdownMenuItem<int>> getDressTypeDropdownItems() {
    return dressTypesList.map((dressType) {
      return DropdownMenuItem<int>(
        value: dressType['id'],
        child: Text(dressType['name']),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                print('Home option selected');
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                navigateToUserProfilePage(context);
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: 'ALL NECK PATTERNS'),
              Tab(text: 'ADD NEW NECKPATTERN'),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
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
          DropdownButtonFormField(
            // Specify items once here
            items: getDressTypeDropdownItems(),

            value: selectedDressTypeId,

            onChanged: (int? newValue) {
              setState(() {
                selectedDressTypeId = newValue ?? 0;
              });
            },

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
                  'Selected Image: ${_pickedImage!.path}',
                  style: TextStyle(fontSize: 16),
                )
              : Container(),
          TextFormField(
            controller: detailsController,
            decoration: InputDecoration(labelText: 'details'),
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
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedImage != null && pickedImage.path != null) {
      setState(() {
        _pickedImage = pickedImage;
      });
    }
  }

  void navigateToUserProfilePage(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return UserProfilePage(uid: user.uid);
        }),
      );
    }
  }
}

class NeckPatternList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

          List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

          if (documents.isEmpty) {
            return Text('No Neck Patterns available.');
          }

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              return CustomTile(
                name: documents[index]['name'],
                details: documents[index]['details'],
                price: documents[index]['price'],
                dressType: documents[index]['dresstype'],
                image: documents[index]['image'],
              );
            },
          );
        },
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  final String name;
  final String details;
  final double price;
  final String dressType;
  final String image;

  CustomTile({
    required this.name,
    required this.details,
    required this.price,
    required this.dressType,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: 500,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(image),
              ),
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: $name',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'details: $details',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Price: \$${price.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Dress Type: $dressType',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
