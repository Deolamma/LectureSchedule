import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lecture_schedule/Models/exceptionClass.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _userId;
  DateTime? __expiryTime;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (__expiryTime != null &&
        __expiryTime!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token!;
    }
    return null;
  }

  String get userId {
    return _userId!;
  }

  Future<void> _authenticate(
      String? email, String? password, String? urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBSTJdg8rs4PVv4a69WPJV43watO_7fthI');

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw ExceptionClass(responseData['error']['message']);
      }
      _userId = responseData['localId'];
      _token = responseData['idToken'];
      __expiryTime = DateTime.now().add(
        Duration(seconds: int.parse(responseData['expiresIn'])),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String? email, String? password) {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> signin(String? email, String? password) {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
