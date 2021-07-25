import 'package:flutter/material.dart';
import 'package:udesign/screens/products_screen.dart';
import 'package:udesign/screens/profile_screen.dart';
import 'package:udesign/screens/scan_screen.dart';

class Home extends StatefulWidget {
  final index;
  Home({this.index = 0});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var showIcons = true;

  setShowIcon(bool b) {
    showIcons = b;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: null,
      body: DefaultTabController(
        length: 3,
        initialIndex: widget.index,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
            ),
            Scaffold(
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: !showIcons
                    ? null
                    : TabBar(
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
              ),
              body: TabBarView(
                children: <Widget>[
                  ScanScreen(
                    setHomeIcon: setShowIcon,
                  ),
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
