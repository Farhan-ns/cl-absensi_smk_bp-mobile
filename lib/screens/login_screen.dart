import 'package:absensi_smk_bp/components/button.dart';
import 'package:absensi_smk_bp/components/textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 170,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 25),
            const Image(
              height: 90,
              image: AssetImage('assets/icons/logo-bp.png'),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'LOGIN',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF707070),
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 5),
                  MyTextField(textInputType: TextInputType.emailAddress),
                  const SizedBox(height: 15),
                  Text(
                    'Password',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 5),
                  MyTextField(textInputType: TextInputType.emailAddress),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: MyElevatedButton(
                          context,
                          'LOGIN',
                          onPressed: () {
                            context.go('/home');
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Transform.flip(
                      flipX: true,
                      child: const Image(
                        image: AssetImage('assets/images/vector-3.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
