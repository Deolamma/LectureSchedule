import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lecture_schedule/constants.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:date_format/date_format.dart';

import '../Models/class.dart';
import '../Providers/classProvider.dart';

class CreateClassScreen extends StatefulWidget {
  static const routeName = '/CreateClassScreen';
  const CreateClassScreen({Key? key}) : super(key: key);

  @override
  _CreateClassScreenState createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  String? _hour, _minute, _time;

  final _form = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  final _courseCodeFocusNode = FocusNode();
  final _courseTitleFocusNode = FocusNode();
  final _startDateFocusNode = FocusNode();
  final _endDateFocusNode = FocusNode();
  final _timeFocusNode = FocusNode();

  var _newClass = Class(
    courseTitle: "",
    courseCode: "",
    level: 0,
    startDate: '',
    endDate: '',
  );

  @override
  void dispose() {
    _endDateFocusNode.dispose();
    _courseCodeFocusNode.dispose();
    _startDateFocusNode.dispose();
    _courseTitleFocusNode.dispose();
    _timeFocusNode.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _timeController.dispose();

    super.dispose();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controlText) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2019),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      selectedDate = picked;

      controlText.text = DateFormat('dd-MM-yyyy').format(selectedDate);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour! + ' : ' + _minute!;
        _timeController.text = _time!;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    }
  }

  void _saveForm() {
    var isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    Provider.of<ClassProvider>(context, listen: false).addClass(_newClass);

    print(_newClass.endDate);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var currentFocus = FocusScope.of(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Class'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.70,
              width: size.width,
              padding: EdgeInsets.all(10),
              child: Form(
                  key: _form,
                  //Here we use ListView because we do not reallyhave lots of textFormField and our data would not be
                  //when our form slides out of screen but perharps we have lots of textFormFields we use Column instead of LisView
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Level',
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (_) {
                          currentFocus.requestFocus(_courseCodeFocusNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field cannot be left empty';
                          } else if (int.parse(value) != (100) &&
                              int.parse(value) != (200) &&
                              int.parse(value) != (300) &&
                              int.parse(value) != (400) &&
                              int.parse(value) != (500)) {
                            return 'Please enter a valid level';
                          }
                          return null;
                        },
                        //OnSaved is triggered when the Form key's current state is saved
                        onSaved: (value) {
                          _newClass = Class(
                              level: int.parse(value!),
                              courseCode: _newClass.courseCode,
                              courseTitle: _newClass.courseTitle,
                              startDate: _newClass.startDate,
                              endDate: _newClass.endDate,
                              timeOfLecture: _newClass.timeOfLecture);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Course Code',
                        ),
                        textInputAction: TextInputAction.next,
                        focusNode: _courseCodeFocusNode,
                        keyboardType: TextInputType.text,

                        onFieldSubmitted: (_) {
                          currentFocus.requestFocus(_courseTitleFocusNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field cannot be left empty';
                          }
                          return null;
                        },
                        //OnSaved is triggered when the Form key's current state is saved
                        onSaved: (value) {
                          _newClass = Class(
                              level: _newClass.level,
                              courseCode: value,
                              courseTitle: _newClass.courseTitle,
                              startDate: _newClass.startDate,
                              endDate: _newClass.endDate,
                              timeOfLecture: _newClass.timeOfLecture);
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Course title',
                        ),
                        textInputAction: TextInputAction.next,
                        focusNode: _courseTitleFocusNode,
                        keyboardType: TextInputType.text,

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field cannot be left empty';
                          }
                          return null;
                        },

                        //OnSaved is triggered when the Form key's current state is saved
                        onSaved: (value) {
                          _newClass = Class(
                              level: _newClass.level,
                              courseCode: _newClass.courseCode,
                              courseTitle: value,
                              startDate: _newClass.startDate,
                              endDate: _newClass.endDate,
                              timeOfLecture: _newClass.timeOfLecture);
                        },
                      ),
                      InkWell(
                        onTap: () {
                          currentFocus.requestFocus();
                          _selectDate(context, _startDateController);
                        },
                        child: IgnorePointer(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Course start date',
                            ),

                            focusNode: _startDateFocusNode,
                            controller: _startDateController,

                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field cannot be left empty';
                              }
                              return null;
                            },

                            //OnSaved is triggered when the Form key's current state is saved
                            onSaved: (value) {
                              _newClass = Class(
                                  level: _newClass.level,
                                  courseCode: _newClass.courseCode,
                                  courseTitle: _newClass.courseTitle,
                                  startDate: value,
                                  endDate: _newClass.endDate,
                                  timeOfLecture: _newClass.timeOfLecture);
                            },
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          currentFocus.requestFocus();
                          _selectDate(context, _endDateController);
                        },
                        child: IgnorePointer(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Course end date',
                            ),

                            focusNode: _endDateFocusNode,
                            controller: _endDateController,

                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field cannot be left empty';
                              }
                              return null;
                            },

                            //OnSaved is triggered when the Form key's current state is saved
                            onSaved: (value) {
                              _newClass = Class(
                                  level: _newClass.level,
                                  courseCode: _newClass.courseCode,
                                  courseTitle: _newClass.courseTitle,
                                  startDate: _newClass.startDate,
                                  endDate: value,
                                  timeOfLecture: _newClass.timeOfLecture);
                            },
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          currentFocus.requestFocus();
                          _selectTime(context);
                        },
                        child: IgnorePointer(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Time of lecture',
                            ),
                            focusNode: _timeFocusNode,
                            controller: _timeController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field cannot be left empty';
                              }
                              return null;
                            },

                            //OnSaved is triggered when the Form key's current state is saved
                            onSaved: (value) {
                              _newClass = Class(
                                level: _newClass.level,
                                courseCode: _newClass.courseCode,
                                courseTitle: _newClass.courseTitle,
                                startDate: _newClass.startDate,
                                endDate: _newClass.endDate,
                                timeOfLecture: value,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            Container(
              height: 54,
              width: size.width,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(15)),
              child: TextButton(
                onPressed: _saveForm,
                child: Text(
                  'Save Class',
                  style: TextStyle(
                    color: kBackgroundColor,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
