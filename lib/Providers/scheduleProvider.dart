import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lecture_schedule/Models/exceptionClass.dart';
import '../Models/schedule.dart';

class ScheduleProvider with ChangeNotifier {
  List<Schedule> _scheduleItems = [];
  final String? authToken;
  final String? userId;

  ScheduleProvider(this._scheduleItems, this.authToken, this.userId);

  List<Schedule> get scheduleItems {
    return [..._scheduleItems];
  }

  Future<void> addSchedule(Schedule newSchedule) async {
    final url = Uri.parse(
        'https://lecturescheduleapp-default-rtdb.firebaseio.com/$userId/Schedules.json?auth=$authToken');
    try {
      var response = await http.post(url,
          body: json.encode({
            'title': newSchedule.title,
            'location': newSchedule.location,
            'time': newSchedule.time,
            'day': newSchedule.day,
          }));

      print(json.decode(response.body)['name']);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final nSchedule = Schedule(
          title: newSchedule.title,
          location: newSchedule.location,
          time: newSchedule.time,
          day: newSchedule.day,
          id: json.decode(response.body)['name'],
        );
        _scheduleItems.add(nSchedule);
        notifyListeners();
      } else {
        throw ExceptionClass(response.body);
      }
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<void> fetchAndSetSchedule() async {
    var url = Uri.parse(
        'https://lecturescheduleapp-default-rtdb.firebaseio.com/$userId/Schedules.json?auth=$authToken');

    try {
      var response = await http.get(url);
      List<Schedule>? fetchedSchedule = [];
      var extractedData = json.decode(response.body) as Map<String, dynamic>?;
      // ignore: unnecessary_null_comparison
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((scheduleId, scheduleItem) {
        fetchedSchedule.add(Schedule(
          id: scheduleId,
          day: scheduleItem['day'],
          location: scheduleItem['location'],
          time: scheduleItem['time'],
          title: scheduleItem['title'],
        ));
        _scheduleItems = fetchedSchedule;
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteSchedule(String id) async {
    final url = Uri.parse(
        'https://lecturescheduleapp-default-rtdb.firebaseio.com/$userId/Schedules/$id.json?auth=$authToken');
    var scheduleDataIndex =
        _scheduleItems.indexWhere((scheduleItem) => scheduleItem.id == id);
    Schedule? scheduleDataValue = _scheduleItems[scheduleDataIndex];
    var response = await http.delete(url);
    print(response.statusCode);
    _scheduleItems.removeWhere((scheduleItem) => scheduleItem.id == id);
    notifyListeners();
    //if the statusCode returns 400 and above it indicates we have an error;
    if (response.statusCode >= 400) {
      _scheduleItems.insert(scheduleDataIndex, scheduleDataValue);
      notifyListeners();
      throw ExceptionClass('Deleting Failed!!!');
    }
    scheduleDataValue = null;
  }
}
