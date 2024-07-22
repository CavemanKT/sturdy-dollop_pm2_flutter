import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pm2/models/task_data.dart';
import 'package:pm2/models/auth/user.dart';
import 'package:pm2/screens/auth/login_screen.dart';
import 'package:pm2/screens/tasks_screen.dart';
import 'package:pm2/services/notification.dart';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

var user = new User();

class RegistrationScreen extends StatefulWidget {
  static const String routeName = '/registrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();

    if (User.currentUser != null) {
      Navigator.pushNamed(context, TasksScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              child: Text('submit'),
              onLongPress: () async {
                await notificationService.showNotification(
                  0,
                  'Login Successful',
                  'Welcome back',
                  jsonEncode({
                    "title": '123',
                    "body": '123',
                  }),
                );
              },
              onPressed: () async {
                // Perform login logic here
                try {
                  await notificationService.showNotification(
                    0,
                    'Login Successful',
                    'Welcome back',
                    jsonEncode({
                      "title": '123',
                      "body": '123',
                    }),
                  );
                  bool result = await user.signup(usernameController.text,
                      passwordController.text, '', '', '', 'tenant', '1');
                  print(User.currentUser);

                  if (result) {
                    usernameController.clear();
                    passwordController.clear();

                    Navigator.pushNamed(context, LoginScreen.routeName);
                  } else {
                    print('signup failed');
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
