import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../Widgets/custom_bottomNavBar_widget.dart';
import '../Widgets/drawer.dart';
import '../Widgets/facultyGridViewWidget.dart';
import '../Providers/facultyDataProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  // ignore: unused_field
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
    return Scaffold(
        drawer: DrawerScreen(),
        backgroundColor: Colors.white,
        body: Stack(
          children: [HeaderWithTitleAndGridBody(), CustomBottomNavBar()],
        ));
  }
}

class HeaderWithTitleAndGridBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  top: size.height * 0.15,
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
                                    fontFamily: 'Lora',
                                    fontStyle: FontStyle.italic,
                                    color: kBackgroundColor,
                                  )),
                          TextSpan(
                            text: 'Dule',
                            style:
                                Theme.of(context).textTheme.headline3!.copyWith(
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
