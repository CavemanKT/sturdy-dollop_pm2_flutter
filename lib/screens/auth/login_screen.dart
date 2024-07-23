import 'package:flutter/material.dart';
import 'package:pm2/models/task_data.dart';
import 'package:pm2/screens/auth/registration_screen.dart';
import 'package:pm2/models/auth/user.dart';
import 'package:pm2/screens/tasks_screen.dart';
import 'package:pm2/services/notification.dart';

var user = new User();

class LoginScreen extends StatefulWidget {
  static const String routeName = '/loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    listenToNotifications();

    super.initState();
    if (User.currentUser != null) {
      Navigator.pushNamed(context, TasksScreen.routeName);
    }
  }

  //  to listen to any notification clicked or not
  listenToNotifications() {
    print("Listening to notification");
    LocalNotifications.onClickNotification.stream.listen((event) {
      print(event);
      Navigator.pushNamed(
        context,
        RegistrationScreen.routeName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
              child: Text('Login'),
              onPressed: () async {
                // Perform login logic here
                try {
                  await user.login(
                      usernameController.text, passwordController.text);
                  print(User.currentUser);

                  var task = TaskData();
                  task.initializeTasks(User.currentUser['Posts']);

                  usernameController.clear();
                  passwordController.clear();

                  Navigator.pushNamed(context, TasksScreen.routeName);
                } catch (e) {
                  print(e);
                }
              },
            ),
            ElevatedButton(
              child: Text('Register'),
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.routeName);
              },
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.exit_to_app),
              label: Text('simple notification'),
              onPressed: () async {
                LocalNotifications.showSimpleNotification(
                    title: "persistent Notification",
                    body: "This is a simple notification",
                    payload: "This is simple data");
              },
            ),
          ],
        ),
      ),
    );
  }
}
