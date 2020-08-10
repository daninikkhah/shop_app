import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String url =
    'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyA2D2m3GfdbwAYPTeBuULB5_UjpoWkDtGQ';

class Authentication with ChangeNotifier {
  String _token;
  String _id;
  DateTime _expiryDate;

  Future<void> signup(String email, String password) async {
    final response = await http.post(url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));
    print(response.body);
  }
}
