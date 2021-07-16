import 'package:flutter/material.dart';

class ScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan',
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: Center(child: Text('Scan room')),
    );
  }
}
