import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  String name = '';
  String email = '';
  bool registered = false;

  void setNewUser(String name, String email, bool registered) {
    this.name = name;
    this.email = email;
    this.registered = registered;
    notifyListeners();
  }
}
