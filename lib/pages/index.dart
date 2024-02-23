import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/components/item_tile.dart';
import 'user_profile.dart';

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Handle my orders option
              print('My Orders option selected');
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Let's create something unique",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Dress Types",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: DressTypeList(),
          ),
        ],
      ),
    );
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

class DressTypeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('dress_type').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No dress types available.');
        } else {
          var dressTypes = snapshot.data!.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            return DressType(
              imageUrl: data['imagePath'] ?? '',
              name: data['name'] ?? '',
              price: data['min_price'] ?? 0,
            );
          }).toList();

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dressTypes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.2,
            ),
            itemBuilder: (context, index) {
              var dressType = dressTypes[index];
              return ItemTile(
                itemName: dressType.name,
                itemPrice: dressType.price.toString(),
                imagePath: dressType.imageUrl,
                onPressed: () {
                  // Your logic when the item is pressed
                },
              );
            },
          );
        }
      },
    );
  }
    // Navigate to UserProfilePage with the user ID
}

class DressType {
  final String imageUrl;
  final String name;
  final int price;
  
  const DressType({
    this.imageUrl = '',
    this.name = '', 
    this.price = 0,
  });
}