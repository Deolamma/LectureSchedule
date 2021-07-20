import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lecture_schedule/Models/exceptionClass.dart';
import 'package:lecture_schedule/Providers/notificationProvider.dart';
import 'package:lecture_schedule/Providers/scheduleProvider.dart';
import 'package:lecture_schedule/constants.dart';
import 'package:provider/provider.dart';

import '../Models/schedule.dart';

class CreateScheduleScreen extends StatefulWidget {
  static const routeName = '/CreateScheduleScreen';
  const CreateScheduleScreen({Key? key}) : super(key: key);

  @override
  _CreateScheduleScreenState createState() => _CreateScheduleScreenState();
}

class _CreateScheduleScreenState extends State<CreateScheduleScreen> {
  final _form = GlobalKey<FormState>();
  var _isLoading = false;

  var _newSchedule = Schedule(
    location: '',
    title: '',
    time: '',
  );

  String? _hour, _minute, _time;

  TimeOfDay _selectedTime = TimeOfDay(hour: 00, minute: 00);
  DateTime _selectedDate = DateTime.now();
  final _timeFocusNode = FocusNode();
  final _dateFocusNode = FocusNode();

  TextEditingController _timeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _timeFocusNode.dispose();
    _dateFocusNode.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context),
            child: child!,
          );
        });

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _hour = _selectedTime.hour.toString();
        _minute = _selectedTime.minute.toString();
        _time = _hour! + ' : ' + _minute!;
        _timeController.text = _time!;
        _timeController.text = formatDate(
          DateTime(2019, 08, 1, _selectedTime.hour, _selectedTime.minute),
          [hh, ':', nn, ' ', am],
        ).toString();
      });
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2025),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context),
            child: child!,
          );
        });

    if (picked != null) {
      _selectedDate = picked;
      _dateController.text =
          DateFormat('EEE, MMMM d, yyyy').format(_selectedDate);
    }
  }

  Future<void> _saveForm() async {
    var isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      DateTime parsedDate =
          DateFormat('EEE, MMMM d, yyyy').parse(_newSchedule.day!);
      // await Provider.of<Notifications>(context).scheduleNotification(
      //   int.parse(DateTime.now().toString()),
      //   _newSchedule.title!,
      //   _newSchedule.location!,
      // );
      print(int.parse(DateFormat('y').format(parsedDate)));
      print(int.parse(DateFormat('d').format(parsedDate)));
      print(int.parse(DateFormat('M').format(parsedDate)));
      print(int.parse(_hour.toString()));
      print(int.parse(_minute.toString()));

      await Provider.of<ScheduleProvider>(context, listen: false)
          .addSchedule(_newSchedule);
    } on ExceptionClass catch (error) {
      print(error);
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured'),
          content: Text('Something went wrong!!!'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _isLoading = false;
                  Navigator.of(ctx).pop();
                });
              },
              child: Text('Okay'),
            ),
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Schedule'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.5,
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: EdgeInsets.all(5),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Title',
                      ),
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.text,
                      onSaved: (value) {
                        _newSchedule = Schedule(
                          location: _newSchedule.location,
                          title: value,
                          time: _newSchedule.time,
                          day: _newSchedule.day,
                        );
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Location',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      onSaved: (value) {
                        _newSchedule = Schedule(
                          location: value,
                          title: _newSchedule.title,
                          time: _newSchedule.time,
                          day: _newSchedule.day,
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ('This field cannot be empty');
                        }
                        return null;
                      },
                    ),
                    InkWell(
                      onTap: () {
                        currentFocus.requestFocus();
                        _selectTime(context);
                      },
                      child: IgnorePointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Time',
                          ),
                          focusNode: _timeFocusNode,
                          controller: _timeController,
                          onSaved: (value) {
                            _newSchedule = Schedule(
                              time: value,
                              location: _newSchedule.location,
                              title: _newSchedule.title,
                              day: _newSchedule.day,
                            );
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ('This field cannot be empty');
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        currentFocus.requestFocus();
                        _selectDate(context);
                      },
                      child: IgnorePointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Day of schedule',
                          ),
                          focusNode: _dateFocusNode,
                          controller: _dateController,
                          onSaved: (value) {
                            _newSchedule = Schedule(
                              time: _newSchedule.time,
                              location: _newSchedule.location,
                              title: _newSchedule.title,
                              day: value,
                            );
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ('This field cannot be empty');
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            saveFormButton(size, context)
          ],
        ),
      ),
    );
  }

  Container saveFormButton(Size size, BuildContext context) {
    return Container(
      height: 54,
      width: size.width,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(15)),
      child: TextButton(
        onPressed: _saveForm,
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: kPrimaryColor,
                ),
              )
            : Text(
                'Save Schedule',
                style: TextStyle(
                  color: kBackgroundColor,
                  fontFamily: 'Poppins',
                ),
              ),
      ),
    );
  }
}
