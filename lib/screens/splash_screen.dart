import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => context.go('/login'),
          child: const SizedBox.expand(
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/sp.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
