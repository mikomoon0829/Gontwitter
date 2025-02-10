import 'package:flutter/material.dart';

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
    return AlertDialog(title: Text("確認"), content: Text(text), actions: [
      TextButton(
          onPressed: () {
            onConfirmPressed();
            Navigator.of(context).pop();
          },
          child: Text("はい")),
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("いいえ"))
    ]);
  }
}
