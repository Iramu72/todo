import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task_data.dart';
import 'package:todo/models/task_data.dart';
import 'package:todo/widgets/task_tile.dart';
import 'package:provider/provider.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return TaskTile(
              taskTitle: task.name,
              isChecked: task.isDone,
              checkboxCallback: (checkboxState) {
                taskData.updateTask(task);
              },
              longPressCallback: () {
                return showDialog(
                  context: context,
                  barrierDismissible:
                      false, // user must tap button for close dialog!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Delete from the list?'),
                      content: const Text(
                          'This will be deleted from the to-do list'),
                      actions: <Widget>[
                        FlatButton(
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            taskData.deleteTask(task);
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  },
                );
              },
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
