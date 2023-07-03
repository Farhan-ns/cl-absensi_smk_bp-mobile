import 'package:flutter/material.dart';

class ButtonLabel extends StatelessWidget {
  final String text;

  const ButtonLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: const Color(0xFFfafafa),
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
