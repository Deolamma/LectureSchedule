import 'package:flutter/material.dart';
import 'package:lecture_schedule/Screens/classScreen.dart';

import '../constants.dart';

class DepartmentGridTile extends StatelessWidget {
  const DepartmentGridTile({
    Key? key,
    this.bgColor,
    this.id,
    this.name,
  }) : super(key: key);
  final Color? bgColor;
  final String? name;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ClassScreen.routeName);
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: GridTile(
            child: Stack(children: [
              Container(
                color: bgColor,
              ),
              Container(
                color: Colors.black.withOpacity(0.1),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  name!,
                  style: TextStyle(
                      color: kBackgroundColor,
                      fontFamily: 'Poppins',
                      fontSize: 18),
                ),
              ),
            ]),
            footer: GridTileBar(
              backgroundColor: Colors.black.withOpacity(0.5),
              title: Text(
                id!,
                style: TextStyle(fontFamily: 'Poppins'),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
