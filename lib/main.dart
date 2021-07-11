import 'package:flutter/material.dart';
import 'package:lecture_schedule/Screens/HomeScreen.dart';
import 'package:lecture_schedule/Screens/scheduleScreen.dart';
import 'package:provider/provider.dart';

import './constants.dart';

import './Screens/pdfViewScreen.dart';
import './Screens/studentAttendanceScreen.dart';
import './Screens/SignInScreen.dart';
import './Screens/classScreen.dart';
import './Screens/CreateClassScreen.dart';
import './Screens/createScheduleScreen.dart';

import './Providers/classProvider.dart';
import './Providers/scheduleProvider.dart';

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
        ChangeNotifierProvider(
          create: (context) => ScheduleProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Lecture Schedule',
        theme: ThemeData.light().copyWith(
          primaryColor: kPrimaryColor,
          accentColor: Colors.amber,
          colorScheme: ColorScheme.light().copyWith(
            primary: kPrimaryColor.withOpacity(0.9),
          ),
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (context) => HomeScreen(),
          //ClassScreen(),
          // SignUpScreen(),
          ScheduleScreen.routeName: (context) => ScheduleScreen(),
          CreateScheduleScreen.routeName: (context) => CreateScheduleScreen(),
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
