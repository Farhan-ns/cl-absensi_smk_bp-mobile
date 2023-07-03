import 'package:flutter/material.dart';

class MyElevatedButton extends ElevatedButton {
  MyElevatedButton(
    BuildContext context,
    Widget child, {
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
          child: child,
        );
}
