import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final Color? color;
  final VoidCallback? onPressed;
  final bool loading;

  const CommonButton(
      {super.key, required this.text, this.color, this.onPressed,required this.loading});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: loading ? SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.0,
                                          ),
                                        )
                                      : Text(text),
    );
  }
}
