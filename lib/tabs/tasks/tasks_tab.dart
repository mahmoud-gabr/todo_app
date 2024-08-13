import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/tabs/tasks/edit_task_screen.dart';
import 'package:todo_app/tabs/tasks/task_item.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        EasyInfiniteDateTimeLine(
          showTimelineHeader: false,
          firstDate: DateTime.now().subtract(
            const Duration(days: 365),
          ),
          focusDate: tasksProvider.selectedDate,
          lastDate: DateTime.now().add(
            const Duration(days: 365),
          ),
          onDateChange: (selectedDate) {
            tasksProvider.changeSelectedDate(selectedDate);
            tasksProvider.getTasks();
          },
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 16),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) => TaskItem(
              taskModel: tasksProvider.tasks[index],
              onTap: () async {
                TaskModel taskModel = await tasksProvider
                    .getTaskById(tasksProvider.tasks[index].id);
                Navigator.pushNamed(
                  _,
                  EditTaskScreen.routeName,
                  arguments: taskModel,
                );
              },
            ),
            itemCount: tasksProvider.tasks.length,
          ),
        )
      ],
    );
  }
}
