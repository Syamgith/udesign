import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: TextStyle(color: Colors.grey[50]),
        ),
      ),
      body: Center(child: Text('View all products')),
    );
  }
}
