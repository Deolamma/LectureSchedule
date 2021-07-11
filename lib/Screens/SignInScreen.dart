import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../Models/clipClass.dart';
import '../Screens/SignUpScreen.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/SignInScreen';
  const SignInScreen({Key? key}) : super(key: key);

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
                  color: kPrimaryColor,
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     image: AssetImage('Assets/Images/image4.jpg'),
                  //     fit: BoxFit.fill,
                  //   ),
                  // ),
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
              padding: EdgeInsets.only(bottom: 10, left: 15),
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
                        context, SignUpScreen.routeName);
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: kPrimaryColor,
                      fontFamily: 'Poppins',
                      fontSize: 15,
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

class SignUpAuthForm extends StatefulWidget {
  const SignUpAuthForm({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _SignUpAuthFormState createState() => _SignUpAuthFormState();
}

class _SignUpAuthFormState extends State<SignUpAuthForm> {
  final _form = GlobalKey<FormState>();

  var _authData = {
    'fullName': '',
    'email': '',
    'password': '',
  };

  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() {
    var isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    return Form(
      key: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            margin: EdgeInsets.only(left: 32, bottom: 15, right: 32),
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
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (_) {
                currentFocus.requestFocus(_passwordFocusNode);
              },
              onSaved: (value) {
                _authData['email'] = value!;
              },
            ),
          ),
          Container(
            height: 40,
            margin: EdgeInsets.only(left: 32, bottom: 15, right: 32),
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
                obscureText: true,
                focusNode: _passwordFocusNode,
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
                textInputAction: TextInputAction.done,
                onSaved: (value) {
                  _authData['password'] = value!;
                }),
          ),
          GestureDetector(
            onTap: _submitForm,
            child: Container(
              height: 40,
              width: widget.size.width,
              margin: EdgeInsets.only(left: 40, bottom: 15, right: 40),
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
