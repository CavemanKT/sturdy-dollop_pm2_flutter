import 'package:flutter/material.dart';
import 'package:pm2/screens/auth/login_screen.dart';
import 'package:pm2/screens/auth/registration_screen.dart';
import 'package:pm2/screens/tasks_screen.dart';
import 'package:provider/provider.dart';
import 'package:pm2/models/task_data.dart';
import 'package:pm2/services/notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService notificationService = NotificationService();
  await notificationService.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return TaskData();
      },
      child: MaterialApp(
        initialRoute: TasksScreen.routeName,
        routes: {
          TasksScreen.routeName: (context) => TasksScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          RegistrationScreen.routeName: (context) => RegistrationScreen(),
        },
      ),
    );
  }
}
