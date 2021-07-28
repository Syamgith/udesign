import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udesign/models/user_model.dart';
import 'package:udesign/resources/style_resourses.dart';
import 'package:udesign/utils/utils.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Register';
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(appTitle, style: StyleResourse.AppBarTitleStyle),
      ),
      body: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  void createUserInFireStore() async {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    DocumentSnapshot doc = await usersCollection.doc(user.uid).get();
    if (!doc.exists) {
      usersCollection.doc(user.uid).set({
        "id": user.uid,
        "email": user.email,
        "name": user.displayName,
      }).whenComplete(() {
        usersCollection
            .doc(user.uid)
            .collection("preferences")
            .doc("fav-colors")
            .set({});
      });
    }
    //currentUser = User.createUser(doc);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: userNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
              validator: (name) {
                Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                RegExp regex = new RegExp(pattern);
                if (!regex.hasMatch(name) || name.length > 16)
                  return 'Invalid username';
                else
                  return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              validator: (email) {
                Pattern pattern =
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                RegExp regex = new RegExp(pattern);
                if (!regex.hasMatch(email) || email.length > 16)
                  return "Invalid Email";
                else
                  return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    validator: (val) {
                      if (val.isEmpty || val.length > 16)
                        return 'Pasword cannot be empty';
                      return null;
                    }),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: rePasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Re-enter password',
                  ),
                  validator: (password) {
                    if (password != passwordController.text)
                      return "Password doesn't match";
                    else
                      return null;
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            width: 350,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  register();
                }
              },
              child: Text(
                'Register',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          renderAlreadyHaveAccount(),
        ],
      ),
    );
  }

  void register() async {
    try {
      Future.delayed(Duration.zero, () {
        Utils.showProgress(context);
      });
      User user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ))
          .user;
      if (user != null) {
        Utils.hideProgress(context);

        await FirebaseAuth.instance.currentUser
            .updateDisplayName(userNameController.text);
        Utils.setBool('registered', true);
        Utils.setString('name', user.displayName);
        Utils.setString('email', user.email);
        Provider.of<UserModel>(context, listen: false)
            .setNewUser(user.displayName, user.email, true);
        setState(() {});
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Home(index: 2)));

        createUserInFireStore();
      }
    } catch (e) {
      Utils.hideProgress(context);
      print(e);
    }
  }

  Widget renderAlreadyHaveAccount() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Already have account" + " ?",
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Text(
              "Login",
            ),
          ),
        ],
      ),
    );
  }
}
