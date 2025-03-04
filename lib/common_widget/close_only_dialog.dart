import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showCloseOnlyDialog(
  context,
  titleText,
  text,
) {
  showDialog(
      context: context,
      builder: (context) {
        return CloseOnlyDialog(
          title: titleText,
          text: text,
        );
      });
}

class CloseOnlyDialog extends StatelessWidget {
  const CloseOnlyDialog({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: Text(title), content: Text(text), actions: [
      TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text("閉じる"))
    ]);
  }
}
