import 'package:flutter/material.dart';
import 'package:lecture_schedule/constants.dart';

class FacultyGridView extends StatelessWidget {
  final String? bgImage;
  final String? name;
  final String? id;

  FacultyGridView({
    this.bgImage,
    this.name,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: Stack(children: [
          GestureDetector(
            onTap: null,
            child: Image.network(
              bgImage!,
              fit: BoxFit.fitHeight,
              height: double.infinity,
            ),
          ),
          Container(color: Colors.black.withOpacity(0.2)),
          Container(
            padding: EdgeInsets.all(5),
            child: Text(
              name!,
              style: TextStyle(
                  color: kBackgroundColor, fontFamily: 'Poppins', fontSize: 18),
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
    );
  }
}
