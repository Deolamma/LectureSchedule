import 'package:flutter/material.dart';

import '../constants.dart';
import '../Models/clipClass.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/SignInScreen';
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.45,
              width: size.width,
              child: ClipPath(
                clipper: Clipper(),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('Assets/Images/image4.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, bottom: 5, left: 10),
              child: Text(
                'Sign In',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontFamily: 'Poppins',
                  fontSize: 30,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10, left: 10),
              child: Text(
                'Welcome ',
                style: TextStyle(
                  color: kPrimaryColor.withOpacity(0.5),
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SignInAuthForm(size: size),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),
                ),
                InkWell(
                  onTap: null,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: kPrimaryColor,
                      fontFamily: 'Poppins',
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SignInAuthForm extends StatelessWidget {
  const SignInAuthForm({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            margin: EdgeInsets.only(left: 32, bottom: 8, right: 32),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: kPrimaryColor.withOpacity(0.1),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 3,
                  color: kPrimaryColor.withOpacity(0.10),
                ),
              ],
            ),
            child: TextFormField(
              key: null,
              decoration: InputDecoration(
                hintText: 'Fullname',
                hintStyle: TextStyle(
                  color: kFormHintTextColor,
                  fontFamily: 'Poppins',
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            height: 40,
            margin: EdgeInsets.only(left: 32, bottom: 8, right: 32),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: kPrimaryColor.withOpacity(0.1),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 3,
                  color: kPrimaryColor.withOpacity(0.10),
                ),
              ],
            ),
            child: TextFormField(
              key: null,
              decoration: InputDecoration(
                hintText: 'email@futa.edu.ng',
                hintStyle: TextStyle(
                  color: kFormHintTextColor,
                  fontFamily: 'Poppins',
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
              height: 40,
              margin: EdgeInsets.only(left: 32, bottom: 8, right: 32),
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: kPrimaryColor.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 3),
                    blurRadius: 3,
                    color: kPrimaryColor.withOpacity(0.10),
                  ),
                ],
              ),
              child: TextFormField(
                key: null,
                decoration: InputDecoration(
                  hintText: 'Enter password',
                  hintStyle: TextStyle(
                      color: kFormHintTextColor, fontFamily: 'Poppins'),
                  border: InputBorder.none,
                ),
              )),
          Container(
              height: 40,
              margin: EdgeInsets.only(left: 32, bottom: 8, right: 32),
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: kPrimaryColor.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 3),
                    blurRadius: 3,
                    color: kPrimaryColor.withOpacity(0.10),
                  ),
                ],
              ),
              child: TextFormField(
                key: null,
                decoration: InputDecoration(
                  hintText: 'Confirm password',
                  hintStyle: TextStyle(
                      color: kFormHintTextColor, fontFamily: 'Poppins'),
                  border: InputBorder.none,
                ),
              )),
          GestureDetector(
            onTap: null,
            child: Container(
              height: 40,
              width: size.width,
              margin: EdgeInsets.only(left: 40, bottom: 8, right: 40),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                'Sign In',
                style: TextStyle(
                  color: kBackgroundColor,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
