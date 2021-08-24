import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:csv/csv.dart';

class StudentAttendanceScreen extends StatelessWidget {
  static const routeName = '/StudentAttendanceScreen';

  Future<List<List<dynamic>>> loadingCsv(String file) async {
    final csvFile = File(file).openRead();
    return await csvFile
        .transform(utf8.decoder)
        .transform(
          CsvToListConverter(),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final file = ModalRoute.of(context)!.settings.arguments as File?;

    return Scaffold(
        appBar: AppBar(
          title: Text('Attendance'),
        ),
        body: FutureBuilder(
            future: loadingCsv(file!.path),
            builder: (context, snapshot) {
              print(snapshot.data.toString());
              return snapshot.hasError || snapshot.data == null
                  ? Center(
                      child: Text('Data Exists'),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Theme.of(context).accentColor,
                      ),
                    );
            }));
  }
}
