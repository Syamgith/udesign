import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16)
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Email',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
               obscureText: true,
               decoration: InputDecoration(
                 border: OutlineInputBorder(),
                labelText: 'Password',
                ),
              ),
            ],
          )
        ),
        Container(
            height: 50,
            width: 350,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              
            child: FlatButton(
              onPressed: () {},
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.amber, fontSize: 25),
                ),
 
              ),
 
        ),
 
      ],
    );
  }
}

