import 'dart:convert';
import 'dart:io';

import 'package:absensi_smk_bp/commons/api_service.dart';
import 'package:absensi_smk_bp/commons/globals.dart';
import 'package:absensi_smk_bp/commons/snackbar_types.dart';
import 'package:absensi_smk_bp/controllers/notification_controller.dart';
import 'package:absensi_smk_bp/controllers/profile_controller.dart';
import 'package:absensi_smk_bp/models/leave.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveController extends GetxController {
  RxString teacherName = ''.obs;
  RxString selectedFilename = ''.obs;
  RxString selectedFilePath = ''.obs;

  RxBool isSubmitting = false.obs;
  RxBool isFetching = false.obs;

  RxList<Leave> leaveList = <Leave>[].obs;

  int leaveCategoryId = -1;

  late TextEditingController absenceReasonTextController;
  late TextEditingController absenceNoteTextController;
  late TextEditingController fromDateTextController;
  late TextEditingController toDateTextController;

  @override
  void onInit() {
    super.onInit();

    absenceReasonTextController = TextEditingController();
    absenceNoteTextController = TextEditingController();
    fromDateTextController = TextEditingController();
    toDateTextController = TextEditingController();
  }

  @override
  void onClose() {
    absenceReasonTextController.dispose();
    absenceNoteTextController.dispose();
    fromDateTextController.dispose();
    toDateTextController.dispose();
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null) {
      // File file = File(result.files.single.path!);
      PlatformFile file = result.files.first;
      selectedFilename.value = file.name;
      selectedFilePath.value = file.path.toString();
    }
  }

  void handleSubmit() {
    if (!validateAllInputs()) return;

    if (selectedFilePath.string.isEmpty) {
      final snackBar = SnackBarTypes.createFailedSnackbar(
          'Harap pilih dokumen untuk diupload.');
      snackbarKey.currentState?.showSnackBar(snackBar);
      return;
    }

    if (leaveCategoryId < 0) {
      final snackBar = SnackBarTypes.createFailedSnackbar(
          'Something went wrong with leave_id.');
      snackbarKey.currentState?.showSnackBar(snackBar);
      return;
    }

    postLeave(selectedFilePath.value);
  }

  void postLeave(String filePath) async {
    try {
      isSubmitting.value = true;

      var response = await APIService.postMultipart(
        '/leave',
        {
          'leave_type': leaveCategoryId.toString(),
          'absence_reason': absenceReasonTextController.text,
          'absence_note': absenceNoteTextController.text,
          'from_date':
              ProfileController.reverseBirthdate(fromDateTextController.text),
          'to_date':
              ProfileController.reverseBirthdate(toDateTextController.text),
        },
        filePath,
      );

      var body = jsonDecode(response.body);

      if (body['success'] ?? false) {
        final snackBar = SnackBarTypes.createSuccessSnackbar(
            'Berhasil mengupload pengajuan, harap tunggu persetujuan dari admin.');
        snackbarKey.currentState?.showSnackBar(snackBar);

        NotificationController notifController = Get.find();
        LeaveController leaveController = Get.find();
        notifController.fetchNotifications();
        leaveController.fetchLeavesHistory();
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

  bool validateAllInputs() {
    if (absenceReasonTextController.text.isEmpty ||
        absenceNoteTextController.text.isEmpty ||
        fromDateTextController.text.isEmpty ||
        toDateTextController.text.isEmpty) {
      final snackBar =
          SnackBarTypes.createFailedSnackbar('Harap isi semua field.');
      snackbarKey.currentState?.showSnackBar(snackBar);
      return false;
    }
    return true;
  }

  void fetchLeavesHistory() async {
    try {
      isFetching.value = true;

      var response = await APIService.get('/leave');
      var body = jsonDecode(response.body);

      if (body['success'] ?? false) {
        leaveList.clear();
        for (var leaveJson in body['data']) {
          Leave leave = Leave.fromJson(leaveJson);
          leaveList.add(leave);
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

  Future<bool> fetchAbsenceDocTypeIsImage(int leaveId) async {
    try {
      isSubmitting.value = true;

      var response = await APIService.post('/leave/doc/type', {
        'leave_id': leaveId,
      });

      var body = jsonDecode(response.body);

      if (body['success'] ?? false) {
        return body['data']['is_image'];
      }
    } on SocketException {
      final snackBar = SnackBarTypes.createFailedSnackbar(
        'Tidak dapat menjangkau server, periksa koneksi anda.',
      );
      snackbarKey.currentState?.showSnackBar(snackBar);

      return false;
    } finally {
      isSubmitting.value = false;
    }
    return false;
  }
}
