import 'package:flutter/material.dart';
import 'package:lecture_schedule/Models/pdfModel.dart';
import 'package:lecture_schedule/Screens/pdfViewScreen.dart';

class StudentAttendanceScreen extends StatelessWidget {
  static const routeName = '/StudentAttendanceScreen';
  const StudentAttendanceScreen({Key? key}) : super(key: key);

  void onSelected(BuildContext context, int item) async {
    switch (item) {
      case 0:
        {
          final file = await PdfModel.pickFile();
          if (file == null) return;
          Navigator.of(context)
              .pushNamed(PdfViewerScreen.routeName, arguments: file);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text('Open PDF'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
