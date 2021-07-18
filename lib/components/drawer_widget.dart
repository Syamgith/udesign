import 'package:flutter/material.dart';
import 'package:udesign/screens/aboutus_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Text('Hi there!'),
        ),
        ListTile(
          title: Text('About Us'),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AboutUs()));
          },
        ),
        Spacer(),
        ListTile(
          title: Text(
            'Log out',
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
      ],
    ));
  }
}
