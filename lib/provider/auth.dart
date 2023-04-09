import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthCus with ChangeNotifier{
  void signup(String email, String password) async {
    Uri url = Uri.parse("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAqWLFlFneZrrJjK7Dyb2l9m8jt36WU8Ro");

    var response = await http.post(url, body: json.encode({
      "email": email,
      "password": password,
      "returnSecureToken": true,
    }));

    print(json.decode(response.body));
  }
}