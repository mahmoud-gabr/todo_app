import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/tabs/tasks/task_item.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
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
          focusDate: DateTime.now(),
          lastDate: DateTime.now().add(
            const Duration(days: 365),
          ),
        ),
        Expanded(
            child: ListView.builder(
          padding: const EdgeInsets.only(top: 16),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, index) => const TaskItem(),
          itemCount: 10,
        ))
      ],
    );
  }
}
