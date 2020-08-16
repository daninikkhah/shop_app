import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/http_exception.dart';

const String singUpUrl =
    'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyA2D2m3GfdbwAYPTeBuULB5_UjpoWkDtGQ';
const String signInUrl =
    'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyA2D2m3GfdbwAYPTeBuULB5_UjpoWkDtGQ';

class Authentication with ChangeNotifier {
  String _token;
  String _id;
  DateTime _expiryDate;
  Timer _timer;

  String get token {
    if (_expiryDate != null && _expiryDate.isAfter(DateTime.now()))
      return _token;
    return null;
  }

  String get id => _id;

  bool get isAuthenticated => token == null ? false : true;

  Future<void> _authentication(
      {String url, String email, String password}) async {
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null)
        throw HttpException(responseData['error']['message']);
      Duration timeToExpiry =
          Duration(seconds: int.parse(responseData['expiresIn']));
      _token = responseData['idToken'];
      _id = responseData['localId'];
      _expiryDate = DateTime.now().add(timeToExpiry);
      _autoLogout(timeToExpiry);
      notifyListeners();
      String authData = json.encode({
        'token': _token,
        'id': _id,
        'expiryDate': _expiryDate.toIso8601String(),
      });
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('authData', authData);
    } catch (e) {
      //print(e);
      throw e;
    }
  }

  Future<void> signup(String email, String password) =>
      _authentication(url: singUpUrl, email: email, password: password);

  Future<void> signIn(String email, String password) =>
      _authentication(url: signInUrl, email: email, password: password);

  Future logout() async {
    _expiryDate = null;
    _token = null;
    _id = null;
    if (_timer != null) _timer.cancel();
    _timer = null;

    notifyListeners();
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.clear();
    } catch (e) {
      print('errrrrrroooooooooooorrrrrrrrrrr');
      print(e);
    }
  }

  void _autoLogout(Duration remainingTime) =>
      Timer(remainingTime, () => logout());

  Future<bool> autoLogin() async {
    print('autoLogin1');
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (!sharedPreferences.containsKey('authData')) return false;
    final String jsonAuthData = sharedPreferences.getString('authData');
    final authData = json.decode(jsonAuthData) as Map<String, Object>;

    final DateTime expiryDate = DateTime.parse(authData['expiryDate']);
    print('autoLogin2');
    if (expiryDate.isBefore(DateTime.now())) return false;
    final timeTOExpiry = expiryDate.difference(DateTime.now()).inSeconds;
    final String token = authData['token'];
    final String id = authData['id'];
    print('autoLogin3');
    _token = token;
    _id = id;
    _expiryDate = expiryDate;
    print(_id);
    print(_expiryDate);
    print(_token);
    notifyListeners();
    _autoLogout(Duration(seconds: timeTOExpiry));
    return true;
  }
}
