import 'package:flutter/foundation.dart';

class Class with ChangeNotifier {
  String? id;
  int? level;
  String? location;
  String? courseCode;
  String? courseTitle;
  String? startDate;
  String? endDate;
  String? timeOfLecture;

  Class({
    this.id,
    this.level,
    this.courseCode,
    this.courseTitle,
    this.startDate,
    this.endDate,
    this.timeOfLecture,
    this.location,
  });
}
