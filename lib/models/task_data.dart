import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pm2/config.dart';
import 'package:pm2/models/auth/user.dart';
import 'package:pm2/models/task.dart';
import 'dart:collection';

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class TaskData extends ChangeNotifier {
  List<dynamic> _tasks = [];

  UnmodifiableListView get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  Future<void> initializeTasks(lists) async {
    var apiUrl = "$API_URL_CONFIG/api/posts";
    final http.Response response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${User.currentUser['id']}'
      },
    );

    print("response.statusCode: ${response.statusCode}");
    if (response.statusCode == 200) {
      _tasks.addAll(jsonDecode(response.body));
      notifyListeners();
    } else {
      throw Exception('Failed to load tasks.');
    }

    notifyListeners();
  }

  Future<void> addTask(
      String newTaskTitle, String newTaskContent, num id) async {
    var apiUrl = "$API_URL_CONFIG/api/create-post";
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${User.currentUser['id']}'
      },
      body: jsonEncode(<String, String>{
        'title': newTaskTitle,
        'content': newTaskContent,
        'LandlordId': id.toString()
      }),
    );

    print("response.statusCode: ${response.statusCode}");
    if (response.statusCode == 200) {
      _tasks.add(jsonDecode(response.body));
      notifyListeners();
    } else {
      throw Exception('Failed to add task.');
    }
    notifyListeners();
  }

  void updateTask(dynamic task) {
    task.setComplete();
    notifyListeners();
  }

  Future<void> deleteTask(num id) async {
    print("id: $id");
    var apiUrl = "$API_URL_CONFIG/api/posts/$id";
    final http.Response response = await http.delete(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${User.currentUser['id']}'
      },
    );

    print("response.statusCode: ${response.statusCode}");
    if (response.statusCode == 200) {
      _tasks.removeWhere((task) => task['id'] == id);
      notifyListeners();
    } else {
      throw Exception('Failed to delete task.');
    }
    notifyListeners();
  }
}
