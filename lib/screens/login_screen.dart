import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udesign/models/user_model.dart';
import 'package:udesign/resources/style_resourses.dart';
import 'package:udesign/screens/home_screen.dart';
import 'package:udesign/screens/register_screen.dart';
import 'package:udesign/utils/utils.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: StyleResourse.AppBarTitleStyle),
        iconTheme: IconThemeData(color: Colors.white),
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

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Image.asset(
                  "assets/logo.jpeg",
                  height: MediaQuery.of(context).size.height / 6,
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
                    ),
                  ],
                ),
              ),
              forgotPasswordField(),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                width: 350,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: login,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              notAMemberField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget forgotPasswordField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        MaterialButton(
            child: Text(
              "Forgot passwod" + " ?",
              style: StyleResourse.AppBarTitleStyle,
            ),
            onPressed: () {
              Utils.popUpDelayed(context, "Relax & aalojichu nokku kittum");
            }),
      ],
    );
  }

  Widget notAMemberField() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Not a member" + " ?",
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => RegisterScreen()));
            },
            child: Text(
              "Register",
            ),
          ),
        ],
      ),
    );
  }

  void login() async {
    try {
      Future.delayed(Duration.zero, () {
        Utils.showProgress(context);
      });
      User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ))
          .user;
      if (user != null) {
        Utils.hideProgress(context);

        Utils.setBool('registered', true);
        Utils.setString('name', user.displayName);
        Utils.setString('email', user.email);

        Provider.of<UserModel>(context, listen: false)
            .setNewUser(user.displayName, user.email, true);

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Home(index: 2)));
        print(user.displayName);
      }
    } catch (e) {
      Utils.hideProgress(context);
      print(e);
      showAlertInvalidUsernameOrPassword(context);
      emailController.text = "";
      passwordController.text = "";
    }
  }

  showAlertInvalidUsernameOrPassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Invalid username or password"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
