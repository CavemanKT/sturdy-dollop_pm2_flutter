import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:pm2/config.dart';

class Landlord extends ChangeNotifier {
  static var currentUser = null;

  Future<bool> signup(
      username, password, tel, firstName, lastName, role, LandlordId) async {
    var apiUrl = "$API_URL_CONFIG/api/auth/enterprise-signup";
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'tel': tel,
        'firstName': firstName,
        'lastName': lastName,
        'role': role,
        'LandlordId': LandlordId
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to create account.');
    }
  }

  Future<void> login(String username, String password) async {
    var apiUrl = "$API_URL_CONFIG/api/auth/enterprise-login";
    final http.Response response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"username": username, "password": password}));
    print(response.statusCode);
    if (response.statusCode == 200) {
      currentUser = jsonDecode(response.body);
      if (currentUser.containsKey('username')) {
        var username = currentUser['username'];
        // Use the username variable here
        print(username);
      } else {
        // Handle the case where 'username' key is not present in the Map
      }
      notifyListeners();
    } else {
      throw Exception('Failed to login.');
    }
  }

  Future<void> logout() async {
    var apiUrl = "$API_URL_CONFIG/api/auth/enterprise-logout";
    final http.Response response = await http.delete(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print("response.statusCode: ${response.statusCode}");
    if (response.statusCode == 204) {
      currentUser = null;
      notifyListeners();
    } else {
      throw Exception('Failed to logout.');
    }
  }
}
