import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:udesign/models/user_model.dart';
import 'package:udesign/resources/style_resourses.dart';
import 'package:udesign/screens/login_screen.dart';
import 'package:udesign/screens/register_screen.dart';
import 'package:udesign/utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen();
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Color color1 = Colors.black;
  Color color2 = Colors.blue;
  Color color3 = Colors.red;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              'Profile',
              style: StyleResourse.AppBarTitleStyle,
            ),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'Logout') {
                    logout();
                  }
                },
                itemBuilder: (BuildContext context) {
                  return <String>['Logout'].map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              )
            ]),
        body: Consumer<UserModel>(builder: (context, user, _) {
          return user.registered ? userUI(context) : guestUI((context));
        }));
  }

  Widget userUI(context) {
    return Consumer<UserModel>(builder: (context, user, _) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: EdgeInsets.all(10),
                  color: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    height: MediaQuery.of(context).size.height / 4,
                    child: Center(
                        child: Text(
                      'Hi Welcome\n${user.name}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.amber),
                    )),
                  ),
                ),
                SizedBox(height: 16),
                Text('Name: ${user.name}'),
                SizedBox(height: 16),
                Text("Email: ${user.email}"),
                SizedBox(height: 16),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Center(
                                child: Text(
                              'Pick your favorite colors',
                              style: StyleResourse.AppBarTitleStyle,
                            )),
                            onTap: () {},
                          ),
                          SizedBox(height: 16),
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
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
        Center(
          child: Card(
            margin: EdgeInsets.all(10),
            color: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              padding: EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height / 4,
              child: Center(
                  child: Text(
                'Hi there Welcome',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.amber),
              )),
            ),
          ),
        ),
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

  void logout() {
    FirebaseAuth.instance.signOut().then((value) {
      print('logout pressed');
      Utils.setBool('registered', false);
      Utils.setString('name', 'Guest');
      Utils.setString('email', 'none');

      Provider.of<UserModel>(context, listen: false)
          .setNewUser("Guest", "none", false);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false);
    });
  }
}
