import 'package:flutter/material.dart';

import '../constants.dart';
import '../Models/clipClass.dart';
import '../Screens/SignInScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                'Sign Up',
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
                'Welcome Back',
                style: TextStyle(
                  color: kPrimaryColor.withOpacity(0.5),
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SignUpAuthForm(size: size),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, SignInScreen.routeName);
                  },
                  child: Text(
                    'Sign In',
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

class SignUpAuthForm extends StatelessWidget {
  const SignUpAuthForm({
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
                hintText: 'Email',
                icon: Icon(
                  Icons.alternate_email_rounded,
                  color: kFormHintTextColor,
                ),
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
                  hintText: 'Password',
                  icon: Icon(
                    Icons.security,
                    color: kFormHintTextColor,
                  ),
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
                'Sign Up',
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
