import 'package:flutter/material.dart';
import 'package:todo_app/auth/register_screen.dart';
import 'package:todo_app/tabs/tasks/deafault_elevated_botton.dart';
import 'package:todo_app/tabs/tasks/deafult_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordControler = TextEditingController();
  TextEditingController emailControler = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome back!'),
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
                  label: 'Login',
                  onPressed: login,
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pushReplacementNamed(
                    RegisterScreen.routeName,
                  ),
                  child: const Text('Don\'t have an account!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {}
  }
}
