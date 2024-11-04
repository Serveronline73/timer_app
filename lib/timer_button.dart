import 'package:flutter/material.dart';

class TimerButton extends StatelessWidget {
  const TimerButton({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(text),
    );
  }
}
