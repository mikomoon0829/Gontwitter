import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  const EditButton(
      {super.key, required this.buttonText, required this.onEditButtonPressed});

  final String buttonText;
  final VoidCallback onEditButtonPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onEditButtonPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(buttonText),
        ),
      ),
    );
  }
}
