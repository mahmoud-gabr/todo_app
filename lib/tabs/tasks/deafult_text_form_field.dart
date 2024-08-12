import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines,
    this.validator,
  });
  final TextEditingController controller;
  final String hintText;
  final int? maxLines;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      maxLines: maxLines,
      validator: validator,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
