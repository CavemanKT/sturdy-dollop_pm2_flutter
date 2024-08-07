import 'package:flutter/material.dart';
import 'package:pm2/models/auth/landlord.dart';
import 'package:pm2/screens/auth/enterprise_login_screen.dart';
import 'package:pm2/widgets/enterprise_tasks_list.dart';
import 'package:pm2/widgets/tasks_list.dart';
import 'package:pm2/screens/add_task_screen.dart';
import 'package:provider/provider.dart';
import 'package:pm2/models/task_data.dart';

var user = new Landlord();

class EnterpriseTasksScreen extends StatefulWidget {
  static const String routeName = '/enterpriseTasksScreen';

  @override
  State<EnterpriseTasksScreen> createState() => _EnterpriseTasksScreenState();
}

class _EnterpriseTasksScreenState extends State<EnterpriseTasksScreen> {
  bool loggedIn = false;

  @override
  void initState() {
    super.initState();
    if (Landlord.currentUser != null) {
      setState(() {
        loggedIn = true;
      });
    } else {
      setState(() {
        loggedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loggedIn
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text('物业管理系统'),
              automaticallyImplyLeading: false,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () async {
                    print("user is going to logout.");
                    await user.logout();
                    Navigator.pop(context);
                    // Navigator.pushNamed(
                    //     context, EnterpriseLoginScreen.routeName);
                  },
                )
              ],
            ),
            backgroundColor: Colors.lightBlueAccent,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        child: Icon(
                          Icons.list,
                          size: 30.0,
                          color: Colors.lightBlueAccent,
                        ),
                        backgroundColor: Colors.white,
                        radius: 30.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Todoey',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${Provider.of<TaskData>(context).taskCount} Tasks',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: EnterpriseTasksList(),
                  ),
                ),
              ],
            ),
          )
        : EnterpriseLoginScreen();
  }
}
