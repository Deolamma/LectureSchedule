import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../Providers/classProvider.dart';
import '../Screens/CreateClassScreen.dart';
import '../Widgets/class_item_widget.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({Key? key}) : super(key: key);

  @override
  _ClassScreenState createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  int _weeksInDate(DateTime start, DateTime end) {
    start = DateTime(start.year, start.month, start.day);
    end = DateTime(end.year, end.month, end.day);

    return ((end.difference(start).inDays / 7)).round();
  }

  @override
  Widget build(BuildContext context) {
    var classData = Provider.of<ClassProvider>(context).classItem;

    return Scaffold(
      appBar: AppBar(
        title: Text('Classes'),
        centerTitle: true,
      ),
      body: classData.isEmpty
          ? Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'No Classes Created yet!!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kBackgroundColor,
                        fontFamily: 'Fredericka',
                        fontSize: 25,
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(CreateClassScreen.routeName);
                        },
                        icon: Icon(
                          Icons.add,
                          color: kBackgroundColor,
                        ),
                        label: Text(
                          'Create Class',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: kBackgroundColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemCount: classData.length,
              itemBuilder: (context, index) {
                DateTime toParseS =
                    DateFormat('dd-MM-yyyy').parse(classData[index].startDate!);
                DateTime toParseE =
                    DateFormat('dd-MM-yyyy').parse(classData[index].endDate!);

                var extractWeekNo = _weeksInDate(toParseS, toParseE);

                var extractDay = DateFormat('E').format(toParseS);

                return ClassItem(
                  day: extractDay,
                  timeOfLecture: classData[index].timeOfLecture,
                  level: (classData[index].level).toString(),
                  courseCode: classData[index].courseCode,
                  courseTitle: classData[index].courseTitle,
                  duration: extractWeekNo.toString(),
                );
              }),
      floatingActionButton: classData.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CreateClassScreen.routeName);
              },
              child: Icon(
                Icons.add,
              ),
            ),
    );
  }
}
