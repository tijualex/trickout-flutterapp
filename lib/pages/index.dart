import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/components/item_tile.dart';

class PageOne extends StatelessWidget {
  // Example list of static items
  List<Map<String, dynamic>> _staticItemList = [
    {
      'name': 'Shirts',
      'price': '20.00',
      'imagePath': 'assets/item1.png',
      'color': Colors.blue,
    },
    {
      'name': 'Gowns',
      'price': '30.00',
      'imagePath': 'assets/item2.png',
      'color': Colors.green,
    },
    // Add more items as needed
  ];

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
              print('Profile option selected');
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
          // Let's order fresh items for you
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Let's create something unique for you",
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

          // categories -> horizontal listview
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Dress Types",
              style: TextStyle(
                fontSize: 18,
                //fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _staticItemList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.2,
              ),
              itemBuilder: (context, index) {
                return ItemTile(
                  itemName: _staticItemList[index]['name'],
                  itemPrice: _staticItemList[index]['price'],
                  imagePath: _staticItemList[index]['imagePath'],
                  color: _staticItemList[index]['color'],
                  onPressed: () {
                    // Your logic when the item is pressed
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
