import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String singUpUrl =
    'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyA2D2m3GfdbwAYPTeBuULB5_UjpoWkDtGQ';
const String signInUrl =
    'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyA2D2m3GfdbwAYPTeBuULB5_UjpoWkDtGQ';

class Authentication with ChangeNotifier {
  String _token;
  String _id;
  DateTime _expiryDate;

  Future<void> signup(String email, String password) async {
    final response = await http.post(singUpUrl,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));
    print(response.body);
  }

  Future<void> signIn(String email, String password) async {
    final response = await http.post(
      signInUrl,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    print(response.body);
  }
}
