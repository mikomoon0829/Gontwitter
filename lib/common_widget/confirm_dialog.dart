import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showConfirmDialog({context, text, onConfirmPressed}) {
  showDialog(
      context: context,
      builder: (context) {
        return ConfirmDialog(
          text: text,
          onConfirmPressed: onConfirmPressed,
        );
      });
}

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.text,
    required this.onConfirmPressed,
  });

  final String text;
  final VoidCallback onConfirmPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: const Text("確認"), content: Text(text), actions: [
      TextButton(
          onPressed: () {
            onConfirmPressed();
            context.pop();
          },
          child: const Text("はい")),
      TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text("いいえ"))
    ]);
  }
}
