import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/facultyDataProvider.dart';
import '../Widgets/departmentGridTile.dart';

class DepartmentScreen extends StatefulWidget {
  const DepartmentScreen({Key? key}) : super(key: key);
  static const routeName = '/DepartmentScreen';

  @override
  _DepartmentScreenState createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  var _isInit = true;
  var _isLoading = false;
  var index = 0;

  var _availableColors = [
    Colors.blue,
    Colors.limeAccent,
    Colors.brown,
    Colors.deepOrange,
    Colors.pink,
    Colors.deepPurpleAccent,
  ];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<FacultyDataProvider>(context).fetchFaculty();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final departmentData =
        Provider.of<FacultyDataProvider>(context).facultyData;
    var id = ModalRoute.of(context)!.settings.arguments as String;

    var currentIndex = departmentData.indexWhere((element) => element.id == id);
    var departmentIndex = departmentData.indexOf(departmentData[currentIndex]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Departments of $id'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).accentColor,
              ),
            )
          : GridView.builder(
              itemCount: currentIndex == departmentIndex
                  ? departmentData[currentIndex].department!.length
                  : 0,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return DepartmentGridTile(
                  id: departmentData[currentIndex].department![index].id,
                  name: departmentData[currentIndex].department![index].name,
                  bgColor: _availableColors[Random().nextInt(6)],
                );
              }),
    );
  }
}
