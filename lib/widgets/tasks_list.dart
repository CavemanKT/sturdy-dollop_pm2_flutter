import 'package:flutter/material.dart';
import 'package:pm2/widgets/task_tile.dart';
import 'package:provider/provider.dart';
import 'package:pm2/models/task_data.dart';
import 'package:pm2/models/auth/user.dart';

class TasksList extends StatefulWidget {
  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  // List<TasksList> tasksList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<TaskData>(context, listen: false)
        .initializeTasks(User.currentUser['Posts']);
  }

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
                // taskData.updateTask(task);
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
