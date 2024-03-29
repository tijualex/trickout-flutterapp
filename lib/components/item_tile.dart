import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

class ItemTile extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String imagePath;
  final color;
  void Function()? onPressed;

  ItemTile({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.imagePath,
    this.color = Colors.white,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // item image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Image.asset(
                imagePath,
                height: 64,
              ),
            ),

            // item name
            Text(
              itemName,
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            MaterialButton(
              onPressed: onPressed,
              color: color,
              child: Text(
                '\$' + itemPrice,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}