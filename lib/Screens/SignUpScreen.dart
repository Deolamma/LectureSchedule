import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lecture_schedule/Models/exceptionClass.dart';
import 'package:lecture_schedule/Providers/Auth.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../Models/clipClass.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/SignUpScreen';
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
                child: Container(color: kPrimaryColor
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //     image: AssetImage('Assets/Images/image4.jpg'),
                    //     fit: BoxFit.fill,
                    //   ),
                    //),
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
              padding: EdgeInsets.only(bottom: 10, left: 15),
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
            SignUpAuthForm(size: size),
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
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/');
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
  var _isLoading = false;
  final _form = GlobalKey<FormState>();

  TextEditingController _passwordController = TextEditingController();

  Map<String?, String?> _authData = {
    'fullName': '',
    'email': '',
    'password': '',
  };

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              setState(() {});
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submitForm() async {
    var _isValid = _form.currentState!.validate();
    if (!_isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).signup(
        _authData['email']!,
        _authData['password']!,
      );
    } on ExceptionClass catch (error) {
      var errorMessage = 'Authentication failed, Exception Class';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Authentication Failed';
      print(error);
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              key: null,
              decoration: InputDecoration(
                hintText: 'Fullname',
                hintStyle: TextStyle(
                  color: kFormHintTextColor,
                  fontFamily: 'Poppins',
                ),
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onSaved: (value) {
                _authData['fullName'] = value!;
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
              decoration: InputDecoration(
                hintText: 'email@futa.edu.ng',
                hintStyle: TextStyle(
                  color: kFormHintTextColor,
                  fontFamily: 'Poppins',
                ),
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field cannot be empty';
                }
                if (!value.contains('@futa.edu.ng')) {
                  return 'Enter a valid email address';
                }
                return null;
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
              decoration: InputDecoration(
                hintText: 'Enter password',
                hintStyle:
                    TextStyle(color: kFormHintTextColor, fontFamily: 'Poppins'),
                border: InputBorder.none,
              ),
              controller: _passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field cannot be empty';
                }
                if (value.length < 8) {
                  return 'Password too short';
                }
                return null;
              },
              onSaved: (value) {
                _authData['password'] = value!;
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
                decoration: InputDecoration(
                  hintText: 'Confirm password',
                  hintStyle: TextStyle(
                      color: kFormHintTextColor, fontFamily: 'Poppins'),
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  if (!(value == _passwordController.text.toString())) {
                    return 'Passwords don\'t match';
                  }
                  return null;
                },
              )),
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
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).accentColor,
                      ),
                    )
                  : Text(
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
