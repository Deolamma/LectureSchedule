import 'package:flutter/material.dart';

import '../constants.dart';

class CreateContentWidget extends StatelessWidget {
  const CreateContentWidget({
    this.noContent,
    this.createContent,
    this.route,
    Key? key,
  }) : super(key: key);

  final String? noContent;
  final String? createContent;
  final String? route;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'No $noContent Created yet!!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kBackgroundColor,
                fontFamily: 'Fredericka',
                fontSize: 25,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(route!);
                },
                icon: Icon(
                  Icons.add,
                  color: kBackgroundColor,
                ),
                label: Text(
                  createContent!,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: kBackgroundColor,
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
