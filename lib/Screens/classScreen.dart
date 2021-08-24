import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../Providers/classProvider.dart';
import '../Models/pdfModel.dart';
import '../Screens/CreateClassScreen.dart';
import '../Screens/pdfViewScreen.dart';
import '../Screens/studentAttendanceScreen.dart';
import '../Widgets/class_item_widget.dart';
import '../Widgets/createContentWidget.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({Key? key}) : super(key: key);
  static const routeName = '/ClassScreen';

  @override
  _ClassScreenState createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  var _isInit = true;
  var _isLoading = false;
  File? file;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ClassProvider>(context).fetchData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  int _weeksInDate(DateTime start, DateTime end) {
    start = DateTime(start.year, start.month, start.day);
    end = DateTime(end.year, end.month, end.day);

    return ((end.difference(start).inDays / 7)).round();
  }

  void onSelected(BuildContext context, int item) async {
    switch (item) {
      case 0:
        {
          file = await PdfModel.pickFile();
          if (file == null) return;
          Navigator.of(context)
              .pushNamed(PdfViewerScreen.routeName, arguments: file);
        }
        break;
      case 1:
        {
          file = await PdfModel.pickCsv();
          if (file == null) return;
          Navigator.of(context)
              .pushNamed(StudentAttendanceScreen.routeName, arguments: file);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var classData = Provider.of<ClassProvider>(context).classItem;

    return Scaffold(
      //drawer: DrawerScreen(),
      appBar: AppBar(
        title: Text('Classes'),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text('Open PDF'),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text('student list'),
              ),
            ],
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).accentColor,
              ),
            )
          : classData.isEmpty
              ? CreateContentWidget(
                  noContent: 'Classes',
                  createContent: 'Create Class',
                  route: CreateClassScreen.routeName,
                )
              : ListView.builder(
                  itemCount: classData.length,
                  itemBuilder: (context, index) {
                    DateTime toParseS = DateFormat('dd-MM-yyyy')
                        .parse(classData[index].startDate!);
                    DateTime toParseE = DateFormat('dd-MM-yyyy')
                        .parse(classData[index].endDate!);

                    var extractWeekNo = _weeksInDate(toParseS, toParseE);

                    var extractDay = DateFormat('E').format(toParseS);

                    return ClassItem(
                      day: extractDay,
                      timeOfLecture: classData[index].timeOfLecture,
                      level: (classData[index].level).toString(),
                      courseCode: classData[index].courseCode,
                      courseTitle: classData[index].courseTitle,
                      location: classData[index].location,
                      duration: extractWeekNo.toString(),
                    );
                  }),
      floatingActionButton: classData.isEmpty
          ? null
          : FloatingActionButton(
              backgroundColor: Theme.of(context).accentColor,
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
