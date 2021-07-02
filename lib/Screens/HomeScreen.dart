import 'package:flutter/material.dart';
import 'package:lecture_schedule/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                height: size.height * 0.3,
                width: size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('Assets/Images/image6.jpg'),
                      fit: BoxFit.cover,
                    ),
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
              )
            ],
          )
        ],
      ),
    );
  }
}
