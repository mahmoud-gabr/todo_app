import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/firebase_function.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(
      {super.key,
      required this.taskModel,
      required this.onTap,
      required this.color});
  final TaskModel taskModel;
  final VoidCallback onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Slidable(
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    FirebaseFunctions.deleteTaskFromFirestore(taskModel.id)
                        .timeout(
                      const Duration(microseconds: 500),
                      onTimeout: () {
                        Provider.of<TasksProvider>(context, listen: false)
                            .getTasks();
                        Fluttertoast.showToast(
                          msg: "Task Deleted Successfuly!",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppTheme.green,
                          textColor: AppTheme.white,
                          fontSize: 16.0,
                        );
                      },
                    ).catchError(
                      (error) {
                        Fluttertoast.showToast(
                          msg: "Somthing Went Worng!",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppTheme.red,
                          textColor: AppTheme.white,
                          fontSize: 16.0,
                        );
                        print(error);
                      },
                    );
                  },
                  backgroundColor: AppTheme.red,
                  foregroundColor: AppTheme.white,
                  icon: Icons.delete,
                  label: 'Delete',
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                color: color,
              ),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 62,
                    margin: const EdgeInsetsDirectional.only(end: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        taskModel.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        taskModel.description,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: color == AppTheme.backgroundItemDark
                                  ? AppTheme.white
                                  : AppTheme.black,
                            ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 69,
                    height: 34,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ImageIcon(
                      const AssetImage('assets/images/Icon-check.png'),
                      size: 34,
                      color: AppTheme.white,
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
