import 'dart:convert';
import 'dart:io';

import 'package:absensi_smk_bp/commons/api_service.dart';
import 'package:absensi_smk_bp/commons/auth_manager.dart';
import 'package:absensi_smk_bp/commons/box_manager.dart';
import 'package:absensi_smk_bp/commons/globals.dart';
import 'package:absensi_smk_bp/commons/hive_model_service.dart';
import 'package:absensi_smk_bp/commons/snackbar_types.dart';
import 'package:absensi_smk_bp/hive_models/profile_hive_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginController extends GetxController {
  late TextEditingController emailTxtController;
  late TextEditingController passwordTxtController;
  RxBool isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();

    emailTxtController = TextEditingController();
    passwordTxtController = TextEditingController();
  }

  @override
  void onClose() {
    emailTxtController.dispose();
    passwordTxtController.dispose();
  }

  Future<bool> attemptLogin() async {
    String email = 'teacher@gmail.com';
    String password = 'pass123';
    // String email = emailTxtController.text;
    // String password = passwordTxtController.text;

    try {
      isSubmitting.value = true;

      var response = await APIService.authenticate({
        'email': email,
        'password': password,
      });

      if (response.statusCode == 500) {
        final snackBar =
            SnackBarTypes.createFailedSnackbar('Ada masalah dengan server.');
        snackbarKey.currentState?.showSnackBar(snackBar);
        return false;
      }

      if (response.statusCode == 401) {
        final snackBar =
            SnackBarTypes.createFailedSnackbar('Email atau password salah.');
        snackbarKey.currentState?.showSnackBar(snackBar);
        return false;
      }

      var body = jsonDecode(response.body);

      if (body['success'] ?? false) {
        AuthManager.addToken(body['data']['token']);

        ProfileHiveModel model =
            HiveModelService.makeHiveProfileModel(body['data']['user']);
        Box profileBox = await BoxManager.getBox('profile');
        profileBox.put('profile', model);

        return true;
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

  bool logout() {
    try {
      AuthManager.removeToken();
      return true;
    } catch (e) {
      final snackBar =
          SnackBarTypes.createFailedSnackbar('Bermasalah saat logout.');
      snackbarKey.currentState?.showSnackBar(snackBar);
      return false;
    }
  }
}
