import 'dart:convert';
import 'dart:io';

import 'package:absensi_smk_bp/commons/api_service.dart';
import 'package:absensi_smk_bp/commons/globals.dart';
import 'package:absensi_smk_bp/commons/snackbar_types.dart';
import 'package:absensi_smk_bp/models/notification_data.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxBool isFetching = false.obs;

  RxList<NotificationData> notificationList = <NotificationData>[].obs;

  void fetchNotifications() async {
    try {
      isFetching.value = true;

      var response = await APIService.get('/notifications');
      var body = jsonDecode(response.body);

      if (body['success'] ?? false) {
        notificationList.clear();
        for (var notifJson in body['data']) {
          NotificationData model = NotificationData.fromJson(notifJson['data']);
          notificationList.add(model);
        }
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
      isFetching.value = false;
    }
  }
}
