import 'package:flutter/material.dart';

class MyElevatedButton extends ElevatedButton {
  MyElevatedButton(
    BuildContext context,
    String text, {
    super.key,
    required super.onPressed,
  }) : super(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFF27a7df),
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              const Color(0xFFfafafa),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: const Color(0xFFfafafa),
                  fontWeight: FontWeight.bold,
                ),
          ),
        );
}
