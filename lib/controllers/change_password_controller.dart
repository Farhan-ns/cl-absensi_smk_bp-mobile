import 'dart:convert';
import 'dart:io';

import 'package:absensi_smk_bp/commons/api_service.dart';
import 'package:absensi_smk_bp/commons/globals.dart';
import 'package:absensi_smk_bp/commons/snackbar_types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  late TextEditingController passwordTxtController;
  late TextEditingController newPasswordTxtController;
  late TextEditingController newPasswordConfirmTxtController;

  RxBool passwordIsHidden = true.obs;
  RxBool newPasswordIsHidden = true.obs;
  RxBool newPasswordConfirmIsHidden = true.obs;
  RxBool isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();

    passwordTxtController = TextEditingController();
    newPasswordTxtController = TextEditingController();
    newPasswordConfirmTxtController = TextEditingController();
  }

  @override
  void onClose() {
    passwordTxtController.dispose();
    newPasswordTxtController.dispose();
    newPasswordConfirmTxtController.dispose();
  }

  Future<bool> changePassword() async {
    if (!_validateInputs()) return false;
    String password = passwordTxtController.text;
    String newPassword = newPasswordTxtController.text;
    String newPasswordConfirm = newPasswordConfirmTxtController.text;

    try {
      isSubmitting.value = true;

      var response = await APIService.post('/change-password', {
        'password': password,
        'new_password': newPassword,
        'new_password_confirmation': newPasswordConfirm,
      });

      var body = jsonDecode(response.body);

      if (body['success'] ?? false) {
        passwordTxtController.text = "";
        newPasswordTxtController.text = "";
        newPasswordConfirmTxtController.text = "";

        return true;
      } else {
        final snackBar = SnackBarTypes.createFailedSnackbar(body['message']);
        snackbarKey.currentState?.showSnackBar(snackBar);
      }
    } on SocketException {
      final snackBar = SnackBarTypes.createFailedSnackbar(
          'Tidak dapat menjangkau server, periksa koneksi anda.');
      snackbarKey.currentState?.showSnackBar(snackBar);
      return false;
    } finally {
      isSubmitting.value = false;
    }
    return false;
  }

  bool _validateInputs() {
    String password = passwordTxtController.text;
    String newPassword = newPasswordTxtController.text;
    String newPasswordConfirm = newPasswordConfirmTxtController.text;
    SnackBar snackBar;

    if (password.isEmpty || newPassword.isEmpty || newPasswordConfirm.isEmpty) {
      snackBar = SnackBarTypes.createFailedSnackbar(
        'Harap isi semua input.',
        duration: 2,
      );
      snackbarKey.currentState?.showSnackBar(snackBar);
      return false;
    }

    return true;
  }
}
