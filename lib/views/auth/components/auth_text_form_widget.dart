import 'package:flutter/material.dart';

class AuthTextFormWidget extends StatelessWidget {
  const AuthTextFormWidget(
      {super.key,
      required this.controller,
      required this.label,
      required this.obscureText});

  final TextEditingController controller;
  final String label;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(label: Text(label)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'テキストを入力してください';
        }
        return null;
      },
      obscureText: obscureText,
    );
  }
}
