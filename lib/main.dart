import 'package:flutter/material.dart';
import 'package:lecture_schedule/Providers/Auth.dart';
import 'package:lecture_schedule/Providers/facultyDataProvider.dart';
import 'package:lecture_schedule/Providers/notificationProvider.dart';
import 'package:lecture_schedule/Screens/HomeScreen.dart';
import 'package:lecture_schedule/Screens/SignUpScreen.dart';
import 'package:lecture_schedule/Screens/scheduleScreen.dart';
import 'package:lecture_schedule/Widgets/drawer.dart';
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
  // await Firebase.initializeApp(),

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProxyProvider<Auth, ClassProvider>(
          create: (context) => ClassProvider('', '', []),
          update: (context, auth, previousClasslist) => ClassProvider(
            auth.token,
            auth.userId,
            previousClasslist == null ? [] : previousClasslist.classItem,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, ScheduleProvider>(
          create: (context) => ScheduleProvider([], '', ''),
          update: (context, auth, previousSchedule) => ScheduleProvider(
            previousSchedule == null ? [] : previousSchedule.scheduleItems,
            auth.token,
            auth.userId,
          ),
        ),
        ChangeNotifierProvider(create: (context) => Notifications()),
        ChangeNotifierProxyProvider<Auth, FacultyDataProvider>(
          create: (context) => FacultyDataProvider([], ''),
          update: (context, auth, previousFacultyData) => FacultyDataProvider(
              previousFacultyData == null
                  ? []
                  : previousFacultyData.facultyData,
              auth.token!),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
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
            '/': (context) => auth.isAuth ? HomeScreen() : SignInScreen(),
            // HomeScreen(),
            ClassScreen.routeName: (context) => ClassScreen(),

            ScheduleScreen.routeName: (context) => ScheduleScreen(),
            CreateScheduleScreen.routeName: (context) => CreateScheduleScreen(),
            StudentAttendanceScreen.routeName: (context) =>
                StudentAttendanceScreen(),
            SignUpScreen.routeName: (context) => SignUpScreen(),
            PdfViewerScreen.routeName: (context) => PdfViewerScreen(),
            CreateClassScreen.routeName: (context) => CreateClassScreen(),
          },
        ),
      ),
    );
  }
}
