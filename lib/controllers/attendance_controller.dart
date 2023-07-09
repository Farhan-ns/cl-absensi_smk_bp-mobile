import 'dart:convert';
import 'dart:io';

import 'package:absensi_smk_bp/commons/api_service.dart';
import 'package:absensi_smk_bp/commons/globals.dart';
import 'package:absensi_smk_bp/commons/snackbar_types.dart';
import 'package:get/get.dart';

class AttendanceController extends GetxController {
  RxBool isFetching = false.obs;
  RxBool isSubmitting = false.obs;

  RxBool connectionError = false.obs;
  RxBool hasCheckinToday = false.obs;
  RxBool hasCheckoutToday = false.obs;

  void checkin() async {
    try {
      isSubmitting.value = true;

      var response = await APIService.post('/checkin', {});

      if (response.statusCode == 423) return showForbiddenIpSnackbar();

      if (response.statusCode >= 500) {
        final snackBar =
            SnackBarTypes.createFailedSnackbar('Ada masalah dengan server.');
        snackbarKey.currentState?.showSnackBar(snackBar);
      }

      var body = jsonDecode(response.body);

      if (body['success'] ?? false) {
        final snackBar =
            SnackBarTypes.createSuccessSnackbar('Berhasil checkin.');
        snackbarKey.currentState?.showSnackBar(snackBar);
        fetchTodaysAttendance();
      } else {
        var errorMessage = body['message'];
        final snackBar = SnackBarTypes.createFailedSnackbar(errorMessage);
        snackbarKey.currentState?.showSnackBar(snackBar);
      }
    } on SocketException {
      final snackBar = SnackBarTypes.createFailedSnackbar(
          'Tidak dapat menjangkau server, periksa koneksi anda.');
      snackbarKey.currentState?.showSnackBar(snackBar);
    } finally {
      isSubmitting.value = false;
    }
  }

  void checkout() async {
    try {
      isSubmitting.value = true;

      var response = await APIService.post('/checkout', {});

      if (response.statusCode == 423) return showForbiddenIpSnackbar();

      if (response.statusCode >= 500) {
        final snackBar =
            SnackBarTypes.createFailedSnackbar('Ada masalah dengan server.');
        snackbarKey.currentState?.showSnackBar(snackBar);
      }

      var body = jsonDecode(response.body);

      if (body['success'] ?? false) {
        final snackBar =
            SnackBarTypes.createSuccessSnackbar('Berhasil checkout.');
        snackbarKey.currentState?.showSnackBar(snackBar);
        fetchTodaysAttendance();
      } else {
        var errorMessage = body['message'];
        final snackBar = SnackBarTypes.createFailedSnackbar(errorMessage);
        snackbarKey.currentState?.showSnackBar(snackBar);
      }
    } on SocketException {
      final snackBar = SnackBarTypes.createFailedSnackbar(
          'Tidak dapat menjangkau server, periksa koneksi anda.');
      snackbarKey.currentState?.showSnackBar(snackBar);
    } finally {
      isSubmitting.value = false;
    }
  }

  void fetchTodaysAttendance() async {
    try {
      connectionError.value = false;
      isFetching.value = true;

      var response = await APIService.get('/check-today-attendance');

      if (response.statusCode >= 500) {
        final snackBar =
            SnackBarTypes.createFailedSnackbar('Ada masalah dengan server.');
        snackbarKey.currentState?.showSnackBar(snackBar);
      }

      var body = jsonDecode(response.body);

      if (body['success'] ?? false) {
        hasCheckinToday.value = body['data']['hasCheckinToday'] ?? false;
        hasCheckoutToday.value = body['data']['hasCheckoutToday'] ?? false;
      } else {
        connectionError.value = true;
        final snackBar =
            SnackBarTypes.createFailedSnackbar(body['success'] ?? 'Error');
        snackbarKey.currentState?.showSnackBar(snackBar);
      }
    } on SocketException {
      connectionError.value = true;
      final snackBar = SnackBarTypes.createFailedSnackbar(
          'Tidak dapat menjangkau server, periksa koneksi anda.');
      snackbarKey.currentState?.showSnackBar(snackBar);
    } finally {
      isFetching.value = false;
    }
  }

  void showForbiddenIpSnackbar() {
    final snackBar = SnackBarTypes.createFailedSnackbar(
      'Anda hanya dapat melakukan absensi ketika terhubung ke jaringan sekolah.',
    );

    snackbarKey.currentState?.showSnackBar(snackBar);
  }
}
