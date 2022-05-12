import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_alta_attedance/models/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel with ChangeNotifier {
  String? _token;
  String? _refreshToken;
  DateTime? _expiryDate;
  String? _userId;
  String? _userEmail;
  String? _password;
  Timer? _authTimer;

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://identitytoolkit.googleapis.com/v1',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  );

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  Future _authenticate(
    String email,
    String password,
    String urlSegment,
  ) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCUhgxlZ8PECDM1aUtPWSw_RuZ0vSba0_A');

    try {
      final response = await Dio().postUri(
        url,
        data: jsonEncode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = response.data;
      _userEmail = email;
      _userId = responseData['localId'];
      _token = responseData['idToken'];
      _refreshToken = responseData['refreshToken'];
      _password = password;
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );

      final prefs = await SharedPreferences.getInstance();

      final userData = jsonEncode(
        {
          'token': _token,
          'refreshToken': _refreshToken,
          'userId': _userId,
          'email': _userEmail,
          'password': _password,
          'expiryDate': _expiryDate!.toIso8601String()
        },
      );
      if (prefs.containsKey('userData')) {
        await prefs.remove('userData');
      }
      await prefs.setString(
        'userData',
        userData,
      );

      notifyListeners();
      return true;
    } on DioError catch (error) {
      return error.response!.data;
    }
  }

  Future signUp(
    String name,
    String email,
    String password,
    DateTime createdAt,
    String nip,
    String job,
  ) async {
    final data = await _authenticate(email.toLowerCase(), password, 'signUp');

    if (data == true) {
      var userData = Account(
          photo: "",
          id: "",
          idUser: _userId!,
          name: name,
          email: email.toLowerCase(),
          password: password,
          createdAt: createdAt,
          nip: nip,
          job: job);
      if (_userId != null) await addUserData(userData);
      return true;
    } else {
      return data;
    }
  }

  Future<void> addUserData(Account userData) async {
    final url = Uri.parse(
        'https://mini-project-flutter-aee89-default-rtdb.firebaseio.com/accounts.json?auth=$_token');
    try {
      await Dio().postUri(
        url,
        data: userData.toJson(),
      );
    } catch (error) {
      rethrow;
    }
  }

  Future signIn(String email, String password) async {
    final data = _authenticate(email, password, 'signInWithPassword');
    if (data == true) {
      return true;
    } else {
      return data;
    }
  }

  Future<void> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return;
    }

    final extractedUserData =
        jsonDecode(prefs.getString('userData').toString());
    //as Map<String, Object>;
    final expiryDate =
        DateTime.parse(extractedUserData['expiryDate'].toString());
    final email = extractedUserData['email'].toString();
    final password = extractedUserData['password'].toString();
    if (expiryDate.isBefore(DateTime.now())) {
      await signIn(email, password);
    } else {
      _token = extractedUserData['token'].toString();
      _userId = extractedUserData['userId'].toString();
      _userEmail = extractedUserData['email'].toString();
      _refreshToken = extractedUserData['refreshToken'].toString();
      _expiryDate = expiryDate;
      notifyListeners();
    }
  }

  Future<void> logOut() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    prefs.clear();
  }
}
