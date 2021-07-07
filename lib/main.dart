import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './constants.dart';
import './Screens/pdfViewScreen.dart';
import './Screens/studentAttendanceScreen.dart';
import './Screens/SignInScreen.dart';
import './Screens/classScreen.dart';
import './Screens/CreateClassScreen.dart';
import './Providers/classProvider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ClassProvider()),
      ],
      child: MaterialApp(
        title: 'Lecture Schedule',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          accentColor: Colors.amber,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (context) => ClassScreen(),
          // SignUpScreen(),
          StudentAttendanceScreen.routeName: (context) =>
              StudentAttendanceScreen(),
          SignInScreen.routeName: (context) => SignInScreen(),
          PdfViewerScreen.routeName: (context) => PdfViewerScreen(),
          CreateClassScreen.routeName: (context) => CreateClassScreen(),
        },
      ),
    );
  }
}
