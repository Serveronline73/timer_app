import 'package:flutter/material.dart';

class TimerButton extends StatelessWidget {
  const TimerButton(
      {super.key,
      required this.textColor,
      required this.text,
      required this.onTap,
      required this.color});

  final String text;
  final Function()? onTap;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          backgroundColor: color, foregroundColor: textColor),
      child: Text(text),
    );
  }
}
