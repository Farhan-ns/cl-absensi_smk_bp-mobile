import 'package:flutter/material.dart';

class MyElevatedButtonIcon extends StatelessWidget {
  final Widget child;
  final Widget icon;
  final Function() onPressed;
  final Color color;

  const MyElevatedButtonIcon(
    this.child,
    this.icon, {
    super.key,
    required this.onPressed,
    this.color = const Color(0xFF27a7df),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: child,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          color,
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
    );
  }
}
