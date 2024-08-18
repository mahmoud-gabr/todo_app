import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';

class DeafaultTextFormField extends StatefulWidget {
  const DeafaultTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.maxLines = 1,
    this.validator,
    this.intialValue,
    this.onChanged,
    this.isPassword = false,
  });
  final TextEditingController? controller;
  final String? hintText;
  final int? maxLines;
  final String? Function(String?)? validator;
  final String? intialValue;
  final Function(String)? onChanged;
  final bool isPassword;

  @override
  State<DeafaultTextFormField> createState() => _DeafaultTextFormFieldState();
}

class _DeafaultTextFormFieldState extends State<DeafaultTextFormField> {
  bool isObscure = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  isObscure = !isObscure;
                  setState(() {});
                },
                icon: isObscure
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.visibility_outlined),
              )
            : null,
      ),
      onChanged: widget.onChanged,
      maxLines: widget.maxLines,
      validator: widget.validator,
      initialValue: widget.intialValue,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: AppTheme.black,
            fontWeight: FontWeight.w400,
          ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: isObscure,
    );
  }
}
