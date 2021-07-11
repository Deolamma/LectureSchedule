import 'package:flutter/material.dart';

import '../constants.dart';
import '../Widgets/custom_bottomNavBar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            HeaderWithTitleAndGridBody(size: size),
            CustomBottomNavBar()
          ],
        ));
  }
}

class HeaderWithTitleAndGridBody extends StatelessWidget {
  const HeaderWithTitleAndGridBody({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: size.height * 0.3,
            width: size.width,
            child: Stack(
              children: [
                Container(
                  height: size.height * 0.3,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(45),
                        bottomRight: Radius.circular(45),
                      )),
                ),
                Positioned(
                  top: 100,
                  left: 20,
                  right: 20,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Lecture',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                      fontFamily: 'poppins',
                                      color: kBackgroundColor,
                                      fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: 'Dule',
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      fontFamily: 'Quicksand',
                                      color: kBackgroundColor,
                                    ),
                          ),
                        ])),

                        Icon(
                          Icons.event_note,
                          color: kBackgroundColor,
                          size: 40,
                        )
                        // Container(
                        //   height: 30,
                        //   width: 30,
                        //   decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //       image: AssetImage('Assets/Images/SchIcon.png'),
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container()
        ],
      ),
    );
  }
}
