import 'package:flutter/material.dart';
import 'package:udesign/screens/products_screen.dart';
import 'package:udesign/screens/profile_screen.dart';
import 'package:udesign/screens/scan_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: null,
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
            ),
            Scaffold(
              bottomNavigationBar: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Column(
                      children: [
                        Icon(Icons.camera_alt),
                        Text(
                          'Scan',
                          style: TextStyle(fontSize: 8),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    icon: Column(
                      children: [
                        Icon(Icons.store),
                        Text(
                          'Products',
                          style: TextStyle(fontSize: 8),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    icon: Column(
                      children: [
                        Icon(Icons.account_circle_rounded),
                        Text(
                          'Profile',
                          style: TextStyle(fontSize: 8),
                        ),
                      ],
                    ),
                  ),
                ],
                labelColor: Theme.of(context).accentColor,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                      color: Theme.of(context).accentColor, width: 0.0),
                  insets: EdgeInsets.only(bottom: 52),
                ),
                unselectedLabelColor: Colors.grey,
              ),
              body: TabBarView(
                children: <Widget>[
                  ScanScreen(),
                  ProductsScreen(),
                  ProfileScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
