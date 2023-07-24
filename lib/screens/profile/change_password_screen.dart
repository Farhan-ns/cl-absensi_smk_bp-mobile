import 'package:absensi_smk_bp/components/appbar.dart';
import 'package:absensi_smk_bp/components/button.dart';
import 'package:absensi_smk_bp/components/button_circular_progress.dart';
import 'package:absensi_smk_bp/components/button_label.dart';
import 'package:absensi_smk_bp/components/textfield.dart';
import 'package:absensi_smk_bp/controllers/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final ChangePasswordController controller =
      Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  'Ganti Password',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  'Password sekarang',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => MyTextField(
                          textInputType: TextInputType.text,
                          controller: controller.passwordTxtController,
                          obscureText: controller.passwordIsHidden.value,
                        ),
                      ),
                    ),
                    Obx(
                      () => IconButton(
                        onPressed: () => controller.passwordIsHidden.value =
                            !controller.passwordIsHidden.value,
                        icon: controller.passwordIsHidden.isTrue
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Password baru',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => MyTextField(
                          textInputType: TextInputType.text,
                          controller: controller.newPasswordTxtController,
                          obscureText: controller.newPasswordIsHidden.value,
                        ),
                      ),
                    ),
                    Obx(
                      () => IconButton(
                        onPressed: () => controller.newPasswordIsHidden.value =
                            !controller.newPasswordIsHidden.value,
                        icon: controller.newPasswordIsHidden.isTrue
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Konfirmasi password baru',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => MyTextField(
                          textInputType: TextInputType.visiblePassword,
                          controller:
                              controller.newPasswordConfirmTxtController,
                          obscureText:
                              controller.newPasswordConfirmIsHidden.value,
                        ),
                      ),
                    ),
                    Obx(
                      () => IconButton(
                        onPressed: () =>
                            controller.newPasswordConfirmIsHidden.value =
                                !controller.newPasswordConfirmIsHidden.value,
                        icon: controller.newPasswordConfirmIsHidden.isTrue
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                    ),
                  ],
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
                              : const ButtonLabel('Simpan'),
                        ),
                        onPressed: () async {
                          var success = await controller.changePassword();

                          if (success && context.mounted) context.pop(true);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
