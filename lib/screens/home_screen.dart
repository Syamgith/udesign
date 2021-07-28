import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udesign/models/user_model.dart';
import 'package:udesign/screens/products_screen.dart';
import 'package:udesign/screens/profile_screen.dart';
import 'package:udesign/screens/scan_screen.dart';
import 'package:udesign/utils/utils.dart';

class Home extends StatefulWidget {
  final index;
  final selectedProduct;
  Home({this.index = 0, this.selectedProduct});

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
  void initState() {
    getDetails();
    super.initState();
  }

  void getDetails() async {
    // final user = FirebaseAuth.instance.currentUser;
    final name = await Utils.getString('name');
    final email = await Utils.getString('email');
    final registered = await Utils.getBool('registered');
    // var name = '';
    // var email = '';
    // var registered = false;
    // if (user != null) {
    //   name = user.displayName;
    //   email = user.email;
    //   registered = true;
    // }
    Provider.of<UserModel>(context, listen: false)
        .setNewUser(name, email, registered);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
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
                                color: Theme.of(context).accentColor,
                                width: 0.0),
                            insets: EdgeInsets.only(bottom: 52),
                          ),
                          unselectedLabelColor: Colors.grey,
                        ),
                ),
                body: TabBarView(
                  children: <Widget>[
                    ScanScreen(
                      setHomeIcon: setShowIcon,
                      selectedProd: widget.selectedProduct ?? null,
                    ),
                    ProductsScreen(),
                    ProfileScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
