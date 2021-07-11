import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../Models/exceptionClass.dart';
import '../Providers/scheduleProvider.dart';

class ScheduleItem extends StatelessWidget {
  const ScheduleItem({
    Key? key,
    this.time,
    this.title,
    this.location,
    this.day,
    this.id,
  }) : super(key: key);

  final String? title;
  final String? time;
  final String? location;
  final String? day;
  final String? id;

  @override
  Widget build(BuildContext context) {
    var scaffold = ScaffoldMessenger.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: kBackgroundColor,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${location!.toUpperCase()}',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(
                      '$title',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      '$day',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      try {
                        await Provider.of<ScheduleProvider>(context,
                                listen: false)
                            .deleteSchedule(id!);
                      } on ExceptionClass catch (error) {
                        scaffold.showSnackBar(SnackBar(
                            content: Text(
                          error.message!,
                          textAlign: TextAlign.center,
                        )));
                      }
                    },
                    child: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                  Text(
                    '$time',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
