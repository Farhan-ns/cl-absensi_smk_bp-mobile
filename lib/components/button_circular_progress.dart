import 'package:flutter/material.dart';

class ButtonCircularProgress extends StatelessWidget {
  const ButtonCircularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 25,
      width: 25,
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
