import 'package:flutter/material.dart';
import 'package:udesign/components/drawer_widget.dart';
import 'package:udesign/resources/style_resourses.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Products',
          style: StyleResourse.AppBarTitleStyle,
        ),
      ),
      body: Center(child: Text('View all products')),
    );
  }
}
