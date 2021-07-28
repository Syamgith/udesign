import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart'
    show ArCoreController;
import 'package:udesign/models/user_model.dart';
import 'package:udesign/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  print('ARCORE IS AVAILABLE?');
  print(await ArCoreController.checkArCoreAvailability());
  print('\nAR SERVICES INSTALLED?');
  print(await ArCoreController.checkIsArCoreInstalled());
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.amber),
        home: Scaffold(
          body: Splash(),
        ),
      ),
    );
  }
}
