import 'package:flutter/material.dart';

class Utils {
  static String getSentenceCase(String name) {
    if (name != null) {
      if (name.length > 1) {
        return name[0].toUpperCase() + name.substring(1, name.length);
      } else {
        return name.toUpperCase();
      }
    }
    return "";
  }

  static showProgress(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  static hideProgress(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
