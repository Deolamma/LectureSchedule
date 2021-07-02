import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';

import './constants.dart';

import './Screens/SignUpScreen.dart';
import './Providers/facultyDataProvider.dart';
import './Screens/SignInScreen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lecture Schedule',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        accentColor: Colors.amber,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => SignUpScreen(),
        SignInScreen.routeName: (context) => SignInScreen(),
      },
    );
  }
}
