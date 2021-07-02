import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/DepartmentModel.dart';
import '../Models/facultyModel.dart';

class FacultyDataProvider with ChangeNotifier {
  CollectionReference facultyItems =
      FirebaseFirestore.instance.collection('facultyItems');
  List<Faculty> _facultyData = [
    Faculty(
      id: 'SAAT',
      name: 'School of Agriculture & Agricultural Technology',
      bgImage: '',
      departments: [
        Department(
          id: 'CSP',
          name: 'Crop, Soil & Pest Management',
        ),
        Department(
          id: 'APH',
          name: 'Animal Production & Health',
        ),
        Department(
          id: 'FWT',
          name: 'Forestry & Wood Technology',
        ),
        Department(
          id: 'ARE',
          name: 'Agricultural & Resource Economics',
        ),
        Department(
          id: 'EWM',
          name: 'Ecotourism & Wildlife Technology',
        ),
        Department(
          id: 'AEC',
          name: 'Agricultural Extension & Communication Technology',
        ),
        Department(
          id: 'FST',
          name: 'Food Science & Technology',
        ),
        Department(
          id: 'FAT',
          name: 'Fisheries & Aquaculture Technology',
        ),
      ],
    ),
    Faculty(
      id: 'SEET',
      name: 'School of Engineering & Engineering Technology',
      bgImage: '',
      departments: [
        Department(
          id: 'AGE',
          name: 'Agricultural Engineering',
        ),
        Department(
          id: 'CVE',
          name: 'Civil Engineering',
        ),
        Department(
          id: 'EEE',
          name: 'Electrical & Electronics Engineering',
        ),
        Department(
          id: 'MEE',
          name: 'Mechanical Engineering',
        ),
        Department(
          id: 'MME',
          name: 'Metallurgical & Materials Engineering',
        ),
        Department(
          id: 'MNE',
          name: 'Mining Engineering',
        ),
      ],
    ),
    Faculty(
        id: 'SEMS',
        name: 'School of Earth & Mineral Sciences',
        bgImage: '',
        departments: [
          Department(
            id: 'AGP',
            name: 'Applied Geophysics',
          ),
          Department(
            id: 'AGY',
            name: 'Applied Geology',
          ),
          Department(
            id: 'MET',
            name: 'Metereology',
          ),
          Department(
            id: 'MST',
            name: 'Marine Science & Technology',
          ),
          Department(
            id: 'RSG',
            name: 'Remote Sensing & Geoscience Information Systems',
          ),
        ]),
    Faculty(
        id: 'SET',
        name: 'School of Environmental Technology',
        bgImage: '',
        departments: [
          Department(
            id: 'ARC',
            name: 'Architecture',
          ),
          Department(
            id: 'BDG',
            name: 'Building Technology',
          ),
          Department(
            id: 'ESM',
            name: 'Estate Management',
          ),
          Department(
            id: 'IDD',
            name: 'Industrial Design',
          ),
          Department(
            id: 'QSV',
            name: 'Quantity Surveying',
          ),
          Department(
            id: 'URP',
            name: 'Urban & Regional Planning',
          ),
          Department(
            id: 'SVG',
            name: 'Surveying & Geoinformatics',
          ),
        ]),
    Faculty(
        id: 'SMAT',
        name: 'School of Management Technology',
        bgImage: '',
        departments: [
          Department(
            id: 'PMT',
            name: 'Project Management Technology',
          ),
          Department(
            id: 'TMT',
            name: 'Transport Management Technology',
          ),
          Department(
            id: 'LMT',
            name: 'Library Management Technology',
          ),
          Department(
            id: 'EMT',
            name: 'Entrepreneurship Management Technology',
          ),
        ]),
    Faculty(
      id: 'SOS',
      name: 'School of Sciences',
      bgImage: '',
      departments: [
        Department(
          id: 'BCH',
          name: 'Biochemistry',
        ),
        Department(
          id: 'BIO',
          name: 'Biology',
        ),
        Department(
          id: 'CHE',
          name: 'Chemistry',
        ),
        Department(
          id: 'GNS',
          name: 'General Studies',
        ),
        Department(
          id: 'MTS',
          name: 'Mathematical Sciences',
        ),
        Department(
          id: 'MCB',
          name: 'Microbiology',
        ),
        Department(
          id: 'PHY',
          name: 'Physics',
        ),
        Department(
          id: 'STA',
          name: 'Statistics',
        ),
      ],
    ),
    Faculty(id: 'SOC', name: 'School of Computing', bgImage: '', departments: [
      Department(
        id: 'CSC',
        name: 'Computer Science',
      ),
      Department(
        id: 'CSS',
        name: 'Cybersecurity',
      ),
      Department(
        id: 'SEN',
        name: 'Software Engineering',
      ),
      Department(
        id: 'IFT',
        name: 'Information Technology',
      ),
      Department(
        id: 'IFS',
        name: 'Information Systems',
      ),
    ])
  ];

  List<Faculty> get facultyData {
    return [..._facultyData];
  }

  void setAndFetchData() {
    //
  }
}
