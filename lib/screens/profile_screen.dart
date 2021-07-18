import 'package:flutter/material.dart';
import 'package:udesign/components/drawer_widget.dart';
import 'package:udesign/resources/style_resourses.dart';
import 'package:udesign/screens/login_screen.dart';
import 'package:udesign/screens/register_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Profile',
          style: StyleResourse.AppBarTitleStyle,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(child: Text('Hi guest!')),
          loginOrRegisterButton(context),
        ],
      ),
    );
    ;
  }

  Widget loginOrRegisterButton(context) {
    return Column(
      children: [
        Text(
          'For personalized recomendations and much more.',
          style: TextStyle(color: Colors.grey),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                )),
            Text('or'),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RegisterScreen()));
                },
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 20),
                )),
          ],
        ),
      ],
    );
  }
}
