import 'package:absensi_smk_bp/components/button.dart';
import 'package:absensi_smk_bp/components/button_circular_progress.dart';
import 'package:absensi_smk_bp/components/button_label.dart';
import 'package:absensi_smk_bp/components/textfield.dart';
import 'package:absensi_smk_bp/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/login-banner.jpg',
                height: 250,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 25),
              const Image(
                height: 95,
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
                    MyTextField(
                      textInputType: TextInputType.emailAddress,
                      controller: controller.emailTxtController,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Password',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(height: 5),
                    MyTextField(
                      textInputType: TextInputType.emailAddress,
                      controller: controller.passwordTxtController,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: MyElevatedButton(
                            context,
                            Obx(
                              () => controller.isSubmitting.value
                                  ? const ButtonCircularProgress()
                                  : const ButtonLabel('LOGIN'),
                            ),
                            onPressed: () async {
                              var success = await controller.attemptLogin();
                              if (success && context.mounted)
                                context.go('/home');
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // FittedBox(
              //   fit: BoxFit.fitWidth,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.only(top: 30),
              //         child: Transform.flip(
              //           flipX: true,
              //           child: const Image(
              //             image: AssetImage('assets/images/vector-3.png'),
              //             height: 150,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
