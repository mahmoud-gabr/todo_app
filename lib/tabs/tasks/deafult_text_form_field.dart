import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({
    super.key,
     this.controller,
     this.hintText,
    this.maxLines,
    this.validator, this.intialValue,  this.onChanged,
  });
  final TextEditingController? controller;
  final String? hintText;
  final int? maxLines;
  final String? Function(String?)? validator;
  final String? intialValue;
  final  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      onChanged: onChanged,
      maxLines: maxLines,
      validator: validator,
      initialValue: intialValue,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: AppTheme.black,
            fontWeight: FontWeight.w400,
          ),
    );
  }
}
