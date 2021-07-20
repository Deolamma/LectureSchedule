import 'package:flutter/material.dart';
import 'package:lecture_schedule/Screens/classScreen.dart';
import 'package:provider/provider.dart';

import '../Models/exceptionClass.dart';
import '../Providers/classProvider.dart';
import '../Screens/studentAttendanceScreen.dart';
import '../constants.dart';

class ClassItem extends StatelessWidget {
  final String? id;
  final String? level;
  final String? courseCode;
  final String? courseTitle;
  final String? day;
  final String? duration;
  final String? timeOfLecture;
  const ClassItem({
    this.id,
    this.courseCode,
    this.courseTitle,
    this.duration,
    this.level,
    this.day,
    this.timeOfLecture,
  });

  @override
  Widget build(BuildContext context) {
    var scaffold = ScaffoldMessenger.of(context);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(StudentAttendanceScreen.routeName);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Container(
            height: 50,
            width: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${level}L',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                courseCode!,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                courseTitle!,
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Text(timeOfLecture!),
                    VerticalDivider(
                      thickness: 2,
                      color: Theme.of(context).accentColor,
                    ),
                    Text(day!),
                  ],
                ),
              )
            ],
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    try {
                      await Provider.of<ClassProvider>(context, listen: false)
                          .deleteClass(courseCode!);
                    } on ExceptionClass catch (error) {
                      scaffold.showSnackBar(SnackBar(
                        content: Text(
                          error.message!,
                          textAlign: TextAlign.center,
                        ),
                      ));
                    }
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text('${duration!}wks'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
