import 'package:flutter/material.dart';
import 'package:pm2/screens/auth/enterprise_login_screen.dart';
import 'package:pm2/screens/auth/login_screen.dart';
import 'package:pm2/screens/auth/registration_screen.dart';
import 'package:pm2/screens/tasks_screen.dart';
import 'package:provider/provider.dart';
import 'package:pm2/models/task_data.dart';
import 'package:pm2/services/notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final navigatorKey = GlobalKey<NavigatorState>();

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifications.init();

//  handle in terminated state
  var initialNotification =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (initialNotification?.didNotificationLaunchApp == true) {
    // LocalNotifications.onClickNotification.stream.listen((event) {
    Future.delayed(Duration(seconds: 1), () {
      // print(event);
      navigatorKey.currentState!.pushNamed(RegistrationScreen.routeName,
          arguments: initialNotification?.notificationResponse?.payload);
    });
  }

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
        navigatorKey: navigatorKey,
        initialRoute: TasksScreen.routeName,
        routes: {
          TasksScreen.routeName: (context) => TasksScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          EnterpriseLoginScreen.routeName: (context) => EnterpriseLoginScreen(),
          RegistrationScreen.routeName: (context) => RegistrationScreen(),
        },
      ),
    );
  }
}
