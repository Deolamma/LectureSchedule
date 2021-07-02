import 'package:flutter/material.dart';
import 'package:lecture_schedule/constants.dart';

class FacultyGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: Stack(children: [
          GestureDetector(
            onTap: null,
            child: null,
          ),
          Container(
            child: Text(
              '',
              style: TextStyle(color: kBackgroundColor, fontFamily: 'Poppins'),
            ),
          ),
        ]),
        footer: GridTileBar(
          title: Row(
            children: [
              Text(
                '',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
