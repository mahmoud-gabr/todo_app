import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/auth/user_provider.dart';
import 'package:todo_app/firebase_function.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';
import 'package:todo_app/tabs/tasks/edit_task_screen.dart';
import 'package:todo_app/tabs/tasks/task_item.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  late TasksProvider tasksProvider;
  late bool isDone;
  late String userId;
  bool shouldGetTasks = true;
  @override
  Widget build(BuildContext context) {
    tasksProvider = Provider.of<TasksProvider>(context);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    if (shouldGetTasks == true) {
      userId =
          Provider.of<UserProvider>(context, listen: false).currentUser!.id;
      tasksProvider.getTasks(userId);
    }
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: screenHeight * .19,
              color: AppTheme.primary,
            ),
            PositionedDirectional(
              start: 25,
              top: 60,
              child: Text(
                AppLocalizations.of(context)!.toDo,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: settingsProvider.isDark
                          ? AppTheme.backgroundDark
                          : AppTheme.white,
                      fontSize: 22,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * .15),
              child: EasyInfiniteDateTimeLine(
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
                  tasksProvider.getTasks(userId);
                },
                activeColor: settingsProvider.isDark
                    ? AppTheme.backgroundDark
                    : AppTheme.white,
                dayProps: EasyDayProps(
                  height: 90,
                  activeDayStyle: DayStyle(
                    borderRadius: 5,
                    dayNumStyle: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    monthStrStyle: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 12,
                    ),
                    dayStrStyle: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 12,
                    ),
                  ),
                  inactiveDayStyle: DayStyle(
                    dayNumStyle: TextStyle(
                      color: settingsProvider.isDark
                          ? AppTheme.white
                          : AppTheme.backgroundDark,
                    ),
                    decoration: BoxDecoration(
                      color: settingsProvider.isDark
                          ? AppTheme.backgroundDark
                          : AppTheme.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  todayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: settingsProvider.isDark
                          ? AppTheme.backgroundDark
                          : AppTheme.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: settingsProvider.isDark
                            ? AppTheme.white
                            : AppTheme.black.withOpacity(.6),
                        width: 2,
                      ),
                    ),
                    dayNumStyle: TextStyle(
                      color: settingsProvider.isDark
                          ? AppTheme.white
                          : AppTheme.backgroundDark,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 16),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) {
              return TaskItem(
                isDone: tasksProvider.tasks[index].isDone,
                isDoneTap: () {
                  FirebaseFunctions.updateIsDoneStatus(
                    taskId: tasksProvider.tasks[index].id,
                    isDone: !tasksProvider.tasks[index].isDone,
                    userId: userId,
                  );
                },
                color: settingsProvider.isDark
                    ? AppTheme.backgroundItemDark
                    : AppTheme.white,
                taskModel: tasksProvider.tasks[index],
                onTap: () {
                  // TaskModel taskModel = await tasksProvider.getTaskById(
                  //     tasksProvider.tasks[index].id, userId);
                  Navigator.of(context).pushNamed(
                    EditTaskScreen.routeName,
                    arguments: tasksProvider.tasks[index],
                  );
                },
              );
            },
            itemCount: tasksProvider.tasks.length,
          ),
        )
      ],
    );
  }


  void changTaskStatus(String taskId, bool isDone) {
    FirebaseFunctions.updateIsDoneStatus(
      isDone: isDone,
      userId: userId,
      taskId: taskId,
    );

    setState(() {});
  }
}
