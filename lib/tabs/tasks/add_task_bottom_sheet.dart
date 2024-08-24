import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/auth/user_provider.dart';
import 'package:todo_app/firebase_function.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/tabs/tasks/deafault_elevated_botton.dart';
import 'package:todo_app/tabs/tasks/deafult_text_form_field.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * .56,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.addTask,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.black,
                    ),
              ),
              const SizedBox(
                height: 16,
              ),
              DeafaultTextFormField(
                controller: titleController,
                hintText: AppLocalizations.of(context)!.enterTitle,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'title can not be empty';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              DeafaultTextFormField(
                controller: descriptionController,
                hintText: AppLocalizations.of(context)!.enterDesc,
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
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      const Duration(days: 365),
                    ),
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                  );
                  if (dateTime != null) {
                    selectedDate = dateTime;
                    setState(() {});
                  }
                },
                child: Text(
                  dateFormat.format(selectedDate),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppTheme.black,
                      ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              DeafaultElevetedBotton(
                  label: AppLocalizations.of(context)!.submit,
                  onPressed: () {
                    if (formKey.currentState!.validate()) addTask();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void addTask() {
    final userId =
        Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    FirebaseFunctions.addTaskToFirestore(
      taskModel: TaskModel(
        title: titleController.text,
        description: descriptionController.text,
        date: selectedDate,
      ),
      userId: userId,
    ).then(
      (_) {
        Navigator.of(context).pop();
        Provider.of<TasksProvider>(context, listen: false).getTasks(userId);
        Fluttertoast.showToast(
          msg: "Task Added Successfuly!",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: AppTheme.green,
          textColor: AppTheme.white,
          fontSize: 16.0,
        );
      },
    ).catchError(
      (_) {
        Fluttertoast.showToast(
          msg: "Somthing Went Worng!",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: AppTheme.red,
          textColor: AppTheme.white,
          fontSize: 16.0,
        );
      },
    );
  }
}
