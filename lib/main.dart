import 'package:flutter/material.dart';
import 'package:pm2/models/auth/landlord.dart';
import 'package:pm2/screens/auth/enterprise_login_screen.dart';
import 'package:pm2/screens/auth/login_screen.dart';
import 'package:pm2/screens/auth/registration_screen.dart';
import 'package:pm2/screens/enterprise_tasks.dart';
import 'package:pm2/screens/tasks_screen.dart';
import 'package:provider/provider.dart';
import 'package:pm2/models/task_data.dart';
import 'package:pm2/services/notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:pm2/services/socketio.dart';
import 'package:socket_io_client/socket_io_client.dart';

final navigatorKey = GlobalKey<NavigatorState>();

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  // socket.onConnect((_) {
  //   print('connect --> sent');
  //   socket.on("message", (data) {
  //     print(data);
  //     if (data != null) {
  //       LocalNotifications.showSimpleNotification(
  //         title: "New Task",
  //         body: "New Task Added",
  //         payload: "New Task Added",
  //       );
  //     }
  //   });
  // });

  // socket.connect();
  // socket.on("alertNewTask", (data) {
  //   print("data line 37: $data");

  //   if (data != null &&
  //       Landlord.currentUser != null &&
  //       Landlord.currentUser['id'] == data['LandlordId']) {
  //     LocalNotifications.showSimpleNotification(
  //       title: "New Task",
  //       body: "New Task Added",
  //       payload: "New Task Added",
  //     );
  //   }
  // });
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
          RegistrationScreen.routeName: (context) => RegistrationScreen(),
          EnterpriseLoginScreen.routeName: (context) => EnterpriseLoginScreen(),
          EnterpriseTasksScreen.routeName: (context) => EnterpriseTasksScreen(),
        },
      ),
    );
  }
}
