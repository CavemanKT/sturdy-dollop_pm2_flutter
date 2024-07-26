import 'package:flutter/material.dart';
import 'package:pm2/models/task_data.dart';
import 'package:pm2/screens/auth/login_screen.dart';
import 'package:pm2/screens/auth/registration_screen.dart';
import 'package:pm2/models/auth/landlord.dart';
import 'package:pm2/screens/enterprise_tasks.dart';
import 'package:pm2/screens/tasks_screen.dart';
import 'package:pm2/services/notification.dart';

var user = new Landlord();

class EnterpriseLoginScreen extends StatefulWidget {
  static const String routeName = '/enterpriseLoginScreen';
  @override
  _EnterpriseLoginScreenState createState() => _EnterpriseLoginScreenState();
}

class _EnterpriseLoginScreenState extends State<EnterpriseLoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (Landlord.currentUser != null) {
      Navigator.pushNamed(context, EnterpriseTasksScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Enterprise Login'),
                WidgetSpan(
                  child: Icon(Icons.business),
                  alignment: PlaceholderAlignment.middle,
                ),
              ],
            ),
          ),
        ),
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

                  passwordController.clear();

                  Navigator.pushNamed(context, EnterpriseTasksScreen.routeName);
                } catch (e) {
                  print(e);
                }
              },
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.arrow_back),
              label: Text('back'),
              onPressed: () async {
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
