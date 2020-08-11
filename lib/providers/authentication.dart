import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

const String singUpUrl =
    'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyA2D2m3GfdbwAYPTeBuULB5_UjpoWkDtGQ';
const String signInUrl =
    'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyA2D2m3GfdbwAYPTeBuULB5_UjpoWkDtGQ';

class Authentication with ChangeNotifier {
  String _token;
  String _id;
  DateTime _expiryDate;

  String get token {
    if (_expiryDate != null && _expiryDate.isAfter(DateTime.now()))
      return _token;
    return null;
  }

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
      //print(response.body);
      final responseData = json.decode(response.body);
      if (responseData['error'] != null)
        throw HttpException(responseData['error']['message']);
      _token = responseData['idToken'];
      _id = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signup(String email, String password) =>
      _authentication(url: singUpUrl, email: email, password: password);

  Future<void> signIn(String email, String password) =>
      _authentication(url: signInUrl, email: email, password: password);
}
