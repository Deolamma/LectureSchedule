// import 'package:flutter/material.dart';
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:timezone/data/latest.dart' as tz;
// // import 'package:timezone/timezone.dart' as tz;

// class Notifications with ChangeNotifier {
//   /*Future initialize() async {
//     return await AndroidAlarmManager.initialize();
//   }

//   Future ringOnce({int? year, int? month, int? day, int? hour, int? minute,}) async{
//     var timeStamp = int.parse(DateTime.now().toIso8601String());
//     await AndroidAlarmManager.oneShotAt(DateTime(year!, month!, day!, hour!, minute!), timeStamp, fireAlarm)

//   }
//   // FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//   //     FlutterLocalNotificationsPlugin();

//   // Future initialize() async {
//   //   FlutterLocalNotificationsPlugin fltrNotificationsPlugin =
//   //       FlutterLocalNotificationsPlugin();

//   //   AndroidInitializationSettings androidInitializationSettings =
//   //       AndroidInitializationSettings('ic_launcher');

//   //   IOSInitializationSettings iosInitializationSettings =
//   //       IOSInitializationSettings();

//   //   final InitializationSettings initializationSettings =
//   //       InitializationSettings(
//   //     android: androidInitializationSettings,
//   //     iOS: iosInitializationSettings,
//   //   );

//   //   await fltrNotificationsPlugin.initialize(initializationSettings,
//   //       onSelectNotification: onSelectNotification);
//   //   tz.initializeTimeZones();
//   // }

//   // Future scheduleNotification(
//   //   int? id,
//   //   String title,
//   //   String body,
//   //   // int? year,
//   //   // int? month,
//   //   // int? day,
//   //   // int? hour,
//   //   // int? minute,
//   // ) async {
//   //   var androidNotificationDetails = AndroidNotificationDetails(
//   //     'id',
//   //     'channel',
//   //     'this is my channel',
//   //   );
//   //   var iosNotificationDetails = IOSNotificationDetails();

//   //   // tz.TZDateTime zonedSchedule =
//   //   //     tz.TZDateTime.local(year, month, day, hour, minute);

//   //   await _flutterLocalNotificationsPlugin.zonedSchedule(
//   //       id,
//   //       title,
//   //       body,
//   //       //  zonedSchedule,
//   //       tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
//   //       NotificationDetails(
//   //           android: androidNotificationDetails, iOS: iosNotificationDetails),
//   //       uiLocalNotificationDateInterpretation:
//   //           UILocalNotificationDateInterpretation.absoluteTime,
//   //       androidAllowWhileIdle: true,
//   //       matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);

//   //   // await _flutterLocalNotificationsPlugin.periodicallyShow(id, title, body, RepeatInterval.weekly, notificationDetails);
//   // }

//   // Future 
//   //onSelectNotification(String? payload) async {}
// }

// void fireAlarm(BuildContext context, String? title, String? body){
//   showDialog(context: context, builder: (ctx)=>AlertDialog(
//     title:Text('Alert! Alert! Alert!') ,
//     content: Text('$title \n $body'),
//     actions: [
//       TextButton(onPressed: (){

//       }, child: Text('Ok'),)
//     ],
//   ),);

// }
