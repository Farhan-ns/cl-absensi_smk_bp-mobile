import 'package:absensi_smk_bp/commons/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    AuthManager.hasToken().then((hasToken) {
      if (hasToken) {
        context.go('/home');
      } else {
        context.go('/login');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Image(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/images/sp.png',
            ),
          ),
        ),
      ),
    );
  }
}
