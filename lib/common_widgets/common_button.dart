import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final Color? color;
  final VoidCallback? onPressed;

  const CommonButton(
      {super.key, required this.text, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
