import 'package:flutter/foundation.dart';
import 'package:todo_app/firebase_function.dart';
import 'package:todo_app/models/task_model.dart';

class TasksProvider with ChangeNotifier {
  List<TaskModel> tasks = [];
  DateTime selectedDate = DateTime.now();

  Future<void> getTasks() async {
    List<TaskModel> allTasks =
        await FirebaseFunctions.getAllTasksFromFirebase();
    tasks = allTasks
        .where(
          (task) =>
              task.date.day == selectedDate.day &&
              task.date.month == selectedDate.month &&
              task.date.year == selectedDate.year,
        )
        .toList();
    notifyListeners();
  }

  void changeSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  Future<TaskModel> getTaskById(String taskId) async {
    return await FirebaseFunctions.getTaskById(taskId);
  }

  Future<bool> getIsDoneStatus(String taskId) async {
    return await FirebaseFunctions.getIsDoneStatus(taskId);
  }
}
