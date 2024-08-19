import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/auth/user_provider.dart';
import 'package:todo_app/firebase_function.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/tabs/tasks/deafault_elevated_botton.dart';
import 'package:todo_app/tabs/tasks/deafult_text_form_field.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTaskScreen extends StatefulWidget {
  static const String routeName = '/editTaskScreen';
  const EditTaskScreen({super.key});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  late TaskModel task;
  late DateTime selectedDate;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    task = ModalRoute.of(context)?.settings.arguments as TaskModel;
    selectedDate = task.date;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .19,
            color: Theme.of(context).primaryColor,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppTheme.white,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.toDo,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppTheme.white,
                        fontSize: 22,
                      ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .8,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
            margin: const EdgeInsets.only(
              right: 16,
              left: 16,
              top: 120,
              bottom: 120,
            ),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.editTask,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppTheme.black,
                          ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DeafaultTextFormField(
                      intialValue: task.title,
                      onChanged: (value) {
                        task.title = value;
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Title cannot be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DeafaultTextFormField(
                      intialValue: task.description,
                      onChanged: (value) {
                        task.description = value;
                      },
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'description can not be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      AppLocalizations.of(context)!.selectDate,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppTheme.black,
                          ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: () async {
                        DateTime? dateTime = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now().subtract(const Duration(
                            days: 30,
                          )),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                        );
                        if (dateTime != null) {
                          selectedDate = dateTime;
                          task.date = dateTime;
                          setState(() {});
                        }
                      },
                      child: Text(
                        dateFormat.format(selectedDate),
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.black,
                                ),
                      ),
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                    SizedBox(
                      width: 255,
                      child: DeafaultElevetedBotton(
                        label: AppLocalizations.of(context)!.submit,
                        onPressed: () {
                          editTask();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void editTask() {
    final userId =
        Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    FirebaseFunctions.updateTaskInFirestore(
      taskModel: TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        date: task.date,
      ),
      userId: userId,
    ).then(
      ((_) {
        Navigator.of(context).pop();
        Provider.of<TasksProvider>(context, listen: false).getTasks(userId);
      }),
    ).catchError(
      (e) {},
    );
  }
}
