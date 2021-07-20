import 'package:flutter/material.dart';
import 'package:lecture_schedule/Screens/createScheduleScreen.dart';
import 'package:lecture_schedule/Widgets/drawer.dart';
import 'package:provider/provider.dart';

import '../Providers/scheduleProvider.dart';
import '../Widgets/scheduleItem.dart';
import '../Widgets/createContentWidget.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = '/ScheduleScreen';

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<ScheduleProvider>(context).fetchAndSetSchedule().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var scheduleData = Provider.of<ScheduleProvider>(context).scheduleItems;
    return Scaffold(
      drawer: DrawerScreen(),
      appBar: AppBar(title: Text('My Schedule')),
      backgroundColor: Color(0xFFD0D0E2),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).accentColor,
              ),
            )
          : scheduleData.isEmpty
              ? CreateContentWidget(
                  createContent: 'Create Schedule',
                  noContent: 'Schedule',
                  route: CreateScheduleScreen.routeName,
                )
              : ListView.builder(
                  itemCount: scheduleData.length,
                  itemBuilder: (context, index) {
                    return ScheduleItem(
                      time: scheduleData[index].time,
                      title: scheduleData[index].title,
                      location: scheduleData[index].location,
                      day: scheduleData[index].day,
                      id: scheduleData[index].id,
                    );
                  }),
      floatingActionButton: scheduleData.isEmpty
          ? null
          : FloatingActionButton(
              backgroundColor: Theme.of(context).accentColor,
              onPressed: () {
                Navigator.of(context).pushNamed(CreateScheduleScreen.routeName);
              },
              child: Icon(
                Icons.add,
              ),
            ),
    );
  }
}
