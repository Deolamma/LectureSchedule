import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lecture_schedule/Providers/facultyDataProvider.dart';
import 'package:lecture_schedule/Widgets/drawer.dart';
import 'package:lecture_schedule/Widgets/facultyGridViewWidget.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../Providers/notificationProvider.dart';
import '../Widgets/custom_bottomNavBar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  var _isLoading = false;
  // @override
  // void initState() {
  //   Provider.of<Notifications>(context, listen: false).initialize();
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<FacultyDataProvider>(context).fetchFaculty().then((_) {
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: DrawerScreen(),
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
    final facultyList = Provider.of<FacultyDataProvider>(context).facultyData;
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
                Builder(
                  builder: (context) => Positioned(
                    top: size.height * 0.03,
                    child: Container(
                      width: size.width,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: SvgPicture.asset(
                              'Assets/Icons/menu.svg',
                              height: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: null,
                            icon: SvgPicture.asset(
                              'Assets/Icons/account.svg',
                              height: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.1,
                  left: 20,
                  right: 20,
                  child: Container(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Lecture',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    fontFamily: 'Fredericka',
                                    color: kBackgroundColor,
                                  )),
                          TextSpan(
                            text: 'Dule',
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      fontFamily: 'Poppins',
                                      color: kBackgroundColor,
                                    ),
                          ),
                        ])),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'Assets/Images/appIcon.jpg',
                              ),
                              fit: BoxFit.contain,
                            ),
                            shape: BoxShape.circle,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 50),
            width: size.width,
            height: size.height * 0.7,
            child: GridView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: facultyList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (context, index) {
                  return FacultyGridView(
                    bgImage: facultyList[index].bgImage,
                    id: facultyList[index].id,
                    name: facultyList[index].name,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
