import 'package:flutter/material.dart';
import 'package:pm2/models/auth/user.dart';
import 'package:pm2/models/task.dart';
import 'package:provider/provider.dart';
import 'package:pm2/models/task_data.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskContentController = TextEditingController();
  TextEditingController taskReceiverController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("current user: ${User.currentUser}");
    if (User.currentUser['Landlord'] != null &&
        User.currentUser['Landlord']['landlordName'] != null) {
      setState(() {
        taskReceiverController.text = User.currentUser['Landlord'] != null
            ? User.currentUser['Landlord']['landlordName']
            : '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.lightBlueAccent,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter Task Title',
              ),
              autofocus: true,
              textAlign: TextAlign.center,
              controller: taskTitleController,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter Task Content',
              ),
              autofocus: true,
              textAlign: TextAlign.center,
              controller: taskContentController,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter Task Receiver', // should be company name
              ),
              autofocus: true,
              textAlign: TextAlign.center,
              controller: taskReceiverController,
            ),
            TextButton(
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.lightBlueAccent),
              ),
              onPressed: () {
                Provider.of<TaskData>(context, listen: false).addTask(
                    taskTitleController.text,
                    taskContentController.text,
                    User.currentUser['Landlord']['id']);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
