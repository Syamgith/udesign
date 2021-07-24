import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:udesign/components/drawer_widget.dart';
import 'package:udesign/resources/style_resourses.dart';
import 'package:udesign/screens/login_screen.dart';
import 'package:udesign/screens/register_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Color color1 = Colors.amber;
  Color color2 = Colors.blue;
  Color color3 = Colors.red;
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
      body: userUI(context),
    );
  }

  Widget userUI(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.width / 4,
              child: Text(
                "Name",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            Text("Name"),
            Divider(),
            SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: Center(child: Text('Select your favorite colors')),
                    onTap: () {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.circle,
                            color: color1,
                            size: 35,
                          ),
                          onPressed: () {
                            selectColor(1);
                          }),
                      IconButton(
                          icon: Icon(
                            Icons.circle,
                            color: color2,
                            size: 35,
                          ),
                          onPressed: () {
                            selectColor(2);
                          }),
                      IconButton(
                          icon: Icon(
                            Icons.circle,
                            color: color3,
                            size: 35,
                          ),
                          onPressed: () {
                            selectColor(3);
                          }),
                    ],
                  ),
                  ListTile(
                    title: Text('fav items'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectColor(i) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick Color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: i == 1
                  ? color1
                  : i == 2
                      ? color2
                      : color3,
              onColorChanged: (color) {
                this.setState(() {
                  if (i == 1) {
                    color1 = color;
                  } else if (i == 2) {
                    color2 = color;
                  } else if (i == 3) {
                    color3 = color;
                  }
                });
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ok"))
          ],
        );
      },
    );
  }

  Widget guestUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Center(child: Text('Hi guest!')),
        loginOrRegisterButton(context),
      ],
    );
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
