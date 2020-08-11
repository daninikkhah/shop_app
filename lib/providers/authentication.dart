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

  Future<void> _authentication(
      {String url, String email, String password}) async {
    try {
      final response = await http.post(
        signInUrl,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null)
        throw HttpException(responseData['error']['message']);
    } catch (e) {
      throw e;
    }
  }

  Future<void> signup(String email, String password) =>
      _authentication(url: signInUrl, email: email, password: password);

  Future<void> signIn(String email, String password) =>
      _authentication(url: signInUrl, email: email, password: password);
}
