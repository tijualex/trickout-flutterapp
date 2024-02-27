import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trickout/pages/designer/neckpattern.dart';
import 'package:trickout/pages/designer/toppattern.dart';
import 'package:trickout/pages/designer/bottompattern.dart';
import 'package:trickout/pages/designer/sleevespattern.dart';
import '/components/item_tile.dart';
import 'user_profile.dart';

class DesignerHome extends StatefulWidget {
  @override
  _DesignerHomeState createState() => _DesignerHomeState();
}

class _DesignerHomeState extends State<DesignerHome> {
  // Index for the selected tab
  int _currentIndex = 0;

  // Dummy data for orders
  List<Order> _orders = [
    Order(id: 1, status: 'Completed'),
    Order(id: 2, status: 'Pending'),
    // Add more orders as needed
  ];

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
              Tab(text: 'Order Management'),
              Tab(text: 'Resource Management'),
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
                  // Order Management Tab
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: DefaultTabController(
                      length: 3, // Number of tabs
                      child: Column(
                        children: [
                          TabBar(
                            tabs: [
                              Tab(text: 'All Orders'),
                              Tab(text: 'Pending Orders'),
                              Tab(text: 'Completed Orders'),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                // All Orders Tab
                                ListView(
                                  children: [
                                    // Display all orders
                                    for (int i = 0; i < _orders.length; i++)
                                      ListTile(
                                        title: Text('Order ${_orders[i].id}'),
                                        subtitle: Text(
                                            'Status: ${_orders[i].status}'),
                                      ),
                                  ],
                                ),
                                // Pending Orders Tab
                                ListView(
                                  children: [
                                    // Display pending orders
                                    for (int i = 0; i < _orders.length; i++)
                                      if (_orders[i].status == 'Pending')
                                        ListTile(
                                          title: Text('Order ${_orders[i].id}'),
                                          subtitle: Text(
                                              'Status: ${_orders[i].status}'),
                                        ),
                                  ],
                                ),
                                // Completed Orders Tab
                                ListView(
                                  children: [
                                    // Display completed orders
                                    for (int i = 0; i < _orders.length; i++)
                                      if (_orders[i].status == 'Completed')
                                        ListTile(
                                          title: Text('Order ${_orders[i].id}'),
                                          subtitle: Text(
                                              'Status: ${_orders[i].status}'),
                                        ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ), // Resource Management Tab
                  Container(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        // Row 1
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                navigateToTopPattern(context);
                              },
                              child: CustomTile(
                                  'Manage Top Pattern', Colors.green),
                            ),  ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                navigateToSleevesPattern(context);
                              },
                              child: CustomTile(
                                  'Manage Sleeve Pattern', Colors.green),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                navigateToNeckPattern(context);
                              },
                              child: CustomTile(
                                  'Manage Neck Pattern', Colors.green),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Row 2
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                navigateToBottomPattern(context);
                              },
                              child: CustomTile(
                                  'Manage Bottom Pattern', Colors.green),
                            )
                          ]
                            ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomTile('Manage fabrics', Colors.blue),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

void navigateToNeckPattern(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return NeckPattern();
  }));
}

void navigateToTopPattern(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return TopPattern();
  }));
}

void navigateToSleevesPattern(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return SleevesPattern();
  }));
}


void navigateToBottomPattern(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return BottomPattern();
  }));
}


class Order {
  final int id;
  final String status;

  Order({required this.id, required this.status});
}

// Custom Tile Widget
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
