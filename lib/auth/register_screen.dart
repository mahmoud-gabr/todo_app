import 'package:flutter/material.dart';
import 'package:todo_app/auth/login_screen.dart';
import 'package:todo_app/tabs/tasks/deafault_elevated_botton.dart';
import 'package:todo_app/tabs/tasks/deafult_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/registerScreen';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  TextEditingController emailControler = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Account'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DeafaultTextFormField(
                  controller: nameControler,
                  hintText: 'Name',
                  validator: (value) {
                    if (value == null || value.trim().length < 3) {
                      return 'name can not be less than 3 char';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                DeafaultTextFormField(
                  controller: emailControler,
                  hintText: 'Email',
                  validator: (value) {
                    if (value == null || value.trim().length < 8) {
                      return 'email can not be less than 8 char';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                DeafaultTextFormField(
                  controller: passwordControler,
                  hintText: 'Password',
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.trim().length < 8) {
                      return 'password can not be less than 8 char';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
                DeafaultElevetedBotton(
                  label: 'Create Account',
                  onPressed: register,
                ),
                TextButton(
                    onPressed: () => Navigator.of(context).pushReplacementNamed(
                          LoginScreen.routeName,
                        ),
                    child: const Text('Already have an account!')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {}
  }
}
