import 'package:flutter/material.dart';
import 'package:udesign/resources/style_resourses.dart';

class Utils {
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

  static showLoadingModel(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                  child: CircularProgressIndicator(),
                ),
                Dialog(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Please wait\nModel is loading",
                      textAlign: TextAlign.center,
                      style: StyleResourse.primaryTitleStyle,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  static hideProgress(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static popUpDelayed(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            backgroundColor: Colors.black,
            content: Text(
              text,
              style: StyleResourse.primaryTitleStyle,
            ),
          );
        });
  }
}
