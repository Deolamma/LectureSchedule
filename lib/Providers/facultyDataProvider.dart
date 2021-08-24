import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/facultyModel.dart';

class FacultyDataProvider with ChangeNotifier {
  final String authToken;
  List<Faculty> _facultyData = [];

  FacultyDataProvider(this._facultyData, this.authToken);
  // List<Faculty>  _facultyData = [
  // Faculty(
  //   id: 'SAAT',
  //   name: 'School of Agriculture & Agricultural Technology',
  //   bgImage:
  //       'https://images.unsplash.com/photo-1557234195-bd9f290f0e4d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8YWdyaWN1bHR1cmV8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80',
  //   department: [
  //     Departments(
  //       id: 'CSP',
  //       name: 'Crop, Soil & Pest Management',
  //     ),
  //     Departments(
  //       id: 'APH',
  //       name: 'Animal Production & Health',
  //     ),
  //     Departments(
  //       id: 'FWT',
  //       name: 'Forestry & Wood Technology',
  //     ),
  //     Departments(
  //       id: 'ARE',
  //       name: 'Agricultural & Resource Economics',
  //     ),
  //     Departments(
  //       id: 'EWM',
  //       name: 'Ecotourism & Wildlife Technology',
  //     ),
  //     Departments(
  //       id: 'AEC',
  //       name: 'Agricultural Extension & Communication Technology',
  //     ),
  //     Departments(
  //       id: 'FST',
  //       name: 'Food Science & Technology',
  //     ),
  //     Departments(
  //       id: 'FAT',
  //       name: 'Fisheries & Aquaculture Technology',
  //     ),
  //   ],
  // ),
  // Faculty(
  //   id: 'SEET',
  //   name: 'School of Engineering & Engineering Technology',
  //   bgImage:
  //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVXLmbys0XRDRF5j57PV-gyzm3kKtyLk8Fgw&usqp=CAU',
  //   department: [
  //     Departments(
  //       id: 'AGE',
  //       name: 'Agricultural Engineering',
  //     ),
  //     Departments(
  //       id: 'CVE',
  //       name: 'Civil Engineering',
  //     ),
  //     Departments(
  //       id: 'EEE',
  //       name: 'Electrical & Electronics Engineering',
  //     ),
  //     Departments(
  //       id: 'MEE',
  //       name: 'Mechanical Engineering',
  //     ),
  //     Departments(
  //       id: 'MME',
  //       name: 'Metallurgical & Materials Engineering',
  //     ),
  //     Departments(
  //       id: 'MNE',
  //       name: 'Mining Engineering',
  //     ),
  //   ],
  // ),
  // Faculty(
  //     id: 'SEMS',
  //     name: 'School of Earth & Mineral Sciences',
  //     bgImage:
  //         'https://st4.depositphotos.com/8707842/24704/i/1600/depositphotos_247044348-stock-photo-natural-coal-green-lawn-background.jpg',
  //     department: [
  //       Departments(
  //         id: 'AGP',
  //         name: 'Applied Geophysics',
  //       ),
  //       Departments(
  //         id: 'AGY',
  //         name: 'Applied Geology',
  //       ),
  //       Departments(
  //         id: 'MET',
  //         name: 'Metereology',
  //       ),
  //       Departments(
  //         id: 'MST',
  //         name: 'Marine Science & Technology',
  //       ),
  //       Departments(
  //         id: 'RSG',
  //         name: 'Remote Sensing & Geoscience Information Systems',
  //       ),
  //     ]),
  // Faculty(
  //     id: 'SET',
  //     name: 'School of Environmental Technology',
  //     bgImage:
  //         'https://goodera.com/wp-content/uploads/2019/10/environmental-risks.jpg',
  //     department: [
  //       Departments(
  //         id: 'ARC',
  //         name: 'Architecture',
  //       ),
  //       Departments(
  //         id: 'BDG',
  //         name: 'Building Technology',
  //       ),
  //       Departments(
  //         id: 'ESM',
  //         name: 'Estate Management',
  //       ),
  //       Departments(
  //         id: 'IDD',
  //         name: 'Industrial Design',
  //       ),
  //       Departments(
  //         id: 'QSV',
  //         name: 'Quantity Surveying',
  //       ),
  //       Departments(
  //         id: 'URP',
  //         name: 'Urban & Regional Planning',
  //       ),
  //       Departments(
  //         id: 'SVG',
  //         name: 'Surveying & Geoinformatics',
  //       ),
  //     ]),
  // Faculty(
  //     id: 'SMAT',
  //     name: 'School of Management Technology',
  //     bgImage:
  //         'https://thefactfactor.com/wp-content/uploads/2019/03/Management.png',
  //     department: [
  //       Departments(
  //         id: 'PMT',
  //         name: 'Project Management Technology',
  //       ),
  //       Departments(
  //         id: 'TMT',
  //         name: 'Transport Management Technology',
  //       ),
  //       Departments(
  //         id: 'LMT',
  //         name: 'Library Management Technology',
  //       ),
  //       Departments(
  //         id: 'EMT',
  //         name: 'Entrepreneurship Management Technology',
  //       ),
  //     ]),
  // Faculty(
  //   id: 'SOS',
  //   name: 'School of Sciences',
  //   bgImage:
  //       'https://images.newscientist.com/wp-content/uploads/2021/02/23162716/chemistry.jpg',
  //   department: [
  //     Departments(
  //       id: 'BCH',
  //       name: 'Biochemistry',
  //     ),
  //     Departments(
  //       id: 'BIO',
  //       name: 'Biology',
  //     ),
  //     Departments(
  //       id: 'CHE',
  //       name: 'Chemistry',
  //     ),
  //     Departments(
  //       id: 'GNS',
  //       name: 'General Studies',
  //     ),
  //     Departments(
  //       id: 'MTS',
  //       name: 'Mathematical Sciences',
  //     ),
  //     Departments(
  //       id: 'MCB',
  //       name: 'Microbiology',
  //     ),
  //     Departments(
  //       id: 'PHY',
  //       name: 'Physics',
  //     ),
  //     Departments(
  //       id: 'STA',
  //       name: 'Statistics',
  //     ),
  //   ],
  // ),
  // Faculty(
  //   id: 'SOC',
  //   name: 'School of Computing',
  //   bgImage: 'https://www.optalgosoftsolutions.com/uploads/Computer.jpg',
  //   department: [
  //     Departments(
  //       id: 'CSC',
  //       name: 'Computer Science',
  //     ),
  //     Departments(
  //       id: 'CSS',
  //       name: 'Cybersecurity',
  //     ),
  //     Departments(
  //       id: 'SEN',
  //       name: 'Software Engineering',
  //     ),
  //     Departments(
  //       id: 'IFT',
  //       name: 'Information Technology',
  //     ),
  //     Departments(
  //       id: 'IFS',
  //       name: 'Information Systems',
  //     ),
  //   ],
  // )
  // ];

  List<Faculty> get facultyData => _facultyData;

  // Future<void> addFaculty() async {
  //   facultyData.forEach((e) async {
  //     log("at this point ${e.toJson()} \n\n\n ${json.encode(e.toJson())}");
  //     final url = Uri.parse(
  //         'https://lecturescheduleapp-default-rtdb.firebaseio.com/facultyData.json?auth=$authToken');

  //     final response = await http.post(url, body: json.encode(e.toJson()));

  //     if (response.statusCode == 200) {
  //       print(response.body);
  //       return log("success");
  //     } else {
  //       return log("body --${response.body}");
  //     }
  //   });
  //   return log("all done ${_facultyData.length}");
  // }

  Future<void> fetchFaculty() async {
    final url = Uri.parse(
        'https://lecturescheduleapp-default-rtdb.firebaseio.com/facultyData.json?auth=$authToken');

    final response = await http.get(url);
    List<Faculty>? loadedData = [];

    final extractedData = json.decode(response.body) as Map<String, dynamic>?;

    if (extractedData == null) {
      return;
    }
    extractedData.forEach((dataId, facultyData) {
      loadedData.add(Faculty(
          id: facultyData['id'],
          bgImage: facultyData['bgImage'],
          name: facultyData['name'],
          department: (facultyData['department'] as List<dynamic>)
              .map((e) => Departments(
                    id: e['id'],
                    name: e['name'],
                  ))
              .toList()));
    });

    _facultyData = loadedData;
    notifyListeners();
  }
}
