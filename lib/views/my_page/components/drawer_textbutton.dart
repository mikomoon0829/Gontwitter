import 'package:flutter/material.dart';

class DrawerTextbutton extends StatelessWidget {
  const DrawerTextbutton({
    super.key,
    required this.onButtonPressed,
    required this.text,
  });

  final VoidCallback onButtonPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onButtonPressed();
      },
      child: SizedBox(
        height: 50,
        child: Center(
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
