import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/tabs/tasks/deafault_elevated_botton.dart';
import 'package:todo_app/tabs/tasks/deafult_text_form_field.dart';
import 'package:intl/intl.dart';

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
    return Container(
      height: MediaQuery.of(context).size.height * .56,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                'Add new task',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.backgroundDark,
                    ),
              ),
              const SizedBox(
                height: 16,
              ),
              DefaultTextFormField(
                controller: titleController,
                hintText: 'Enter task title',
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
              DefaultTextFormField(
                controller: descriptionController,
                hintText: 'Enter task description',
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
                'Select date',
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
                  label: 'Submit',
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
    print('Task added');
  }
}
