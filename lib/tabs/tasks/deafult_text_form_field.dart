import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({
    super.key,
     this.controller,
    required this.hintText,
    this.maxLines,
    this.validator, this.intialValue,  this.onChanged,
  });
  final TextEditingController? controller;
  final String hintText;
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
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
