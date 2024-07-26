import 'package:flutter/material.dart';
import 'package:pm2/widgets/task_tile.dart';
import 'package:provider/provider.dart';
import 'package:pm2/models/task_data.dart';
import 'package:pm2/models/auth/landlord.dart';

class EnterpriseTasksList extends StatefulWidget {
  @override
  State<EnterpriseTasksList> createState() => _EnterpriseTasksListState();
}

class _EnterpriseTasksListState extends State<EnterpriseTasksList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<TaskData>(context, listen: false)
        .initializeTasks(Landlord.currentUser['id'], 'landlord');
  }
  // ! still looking for a way to real time update the list and notify the landlord
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
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        print('tasks: ${taskData.tasks}');
        print('fn: ${taskData.runtimeType}');
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return TaskTile(
              taskTitle: task['title'],
              taskContent: task['content'],
              isChecked: task['status'] == 'complete' ? true : false,
              checkboxCallback: () {
                //! need to think of a better way to note the landlord's reminder
                taskData.updateCheckBox(task);
              },
              longPressCallback: () {
                print("task id: ${task['id']}");
                taskData.deleteTask(task['id']);
              },
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
