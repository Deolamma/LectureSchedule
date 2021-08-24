import 'package:flutter/material.dart';

import '../Screens/classScreen.dart';
import '../Screens/scheduleScreen.dart';
import '../constants.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  static const routeName = '/Drawer';

  Widget buildListTile(IconData icon, String text, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: kPrimaryColor,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 24,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        color: Theme.of(context).accentColor,
        child: Column(
          children: <Widget>[
            Container(
              height: size.height * 0.3,
              width: double.infinity,
              color: kPrimaryColor,
              padding: EdgeInsets.all(40),
              alignment: Alignment.topLeft,
              child: Text(
                'LectureDule',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Fredericka',
                    color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            buildListTile(
              Icons.home,
              'Home',
              () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                height: 1,
                color: kPrimaryColor,
              ),
            ),
            buildListTile(
              Icons.event_note,
              'Schedules',
              () {
                Navigator.of(context)
                    .pushReplacementNamed(ScheduleScreen.routeName);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                height: 1,
                color: kPrimaryColor,
              ),
            ),
            buildListTile(
              Icons.book,
              'Classes',
              () {
                //Push replacementNamed is used when we do not want the user to be able to return to the previous page
                //Therefore we delete the page we are coming from as we push in this new page
                //We typically use this when we require a usres authentication prolly a log in page
                //after the user has been authenticated we do not want the user to be able to return to the previous page
                //Hence we us eushReplacementNamed

                Navigator.of(context)
                    .pushReplacementNamed(ClassScreen.routeName);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                height: 1,
                color: kPrimaryColor,
              ),
            ),
            buildListTile(Icons.logout, 'Log Out', () {
              Navigator.of(context)
                  .pushReplacementNamed(ScheduleScreen.routeName);
            }),
          ],
        ),
      ),
    );
  }
}
