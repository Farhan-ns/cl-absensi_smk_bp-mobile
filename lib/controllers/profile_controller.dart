import 'dart:convert';
import 'dart:io';

import 'package:absensi_smk_bp/commons/api_service.dart';
import 'package:absensi_smk_bp/commons/box_manager.dart';
import 'package:absensi_smk_bp/commons/globals.dart';
import 'package:absensi_smk_bp/commons/hive_model_service.dart';
import 'package:absensi_smk_bp/commons/snackbar_types.dart';
import 'package:absensi_smk_bp/hive_models/profile_hive_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  RxBool isInitializing = false.obs;
  RxBool isSubmitting = false.obs;
  RxString name = '-'.obs;
  RxString phone = '-'.obs;
  RxString email = '-'.obs;
  RxString address = '-'.obs;
  RxString birthdate = '-'.obs;
  late TextEditingController nameTxtController;
  late TextEditingController phoneTxtController;
  late TextEditingController emailTxtController;
  late TextEditingController addressTxtController;
  late TextEditingController birthdateTxtController;

  var profile = ProfileHiveModel().obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    nameTxtController = TextEditingController();
    phoneTxtController = TextEditingController();
    emailTxtController = TextEditingController();
    addressTxtController = TextEditingController();
    birthdateTxtController = TextEditingController();

    Box profileBox = await BoxManager.getBox('profile');
    ProfileHiveModel profile = profileBox.get('profile');
    this.profile.value = profile;

    nameTxtController.text = profile.name;
    phoneTxtController.text = profile.phone;
    emailTxtController.text = profile.email;
    addressTxtController.text = profile.address;
    birthdateTxtController.text = profile.birthdate;

    name.value = profile.name;
    phone.value = profile.phone;
    email.value = profile.email;
    address.value = profile.address;
    birthdate.value = profile.birthdate;
  }

  // Might have SocketException Bug
  Future<void> _fetchProfileData() async {
    var response = await APIService.get('/profile');
    var body = jsonDecode(response.body);

    if (body['success'] ?? false) {
      Box profileBox = await BoxManager.getBox('profile');

      profile.value = HiveModelService.makeHiveProfileModel(body['data']);
      profileBox.delete('profile');
      profileBox.put('profile', profile.value);

      name.value = body['data']['name'];
      phone.value = body['data']['phone'];
      email.value = body['data']['email'];
      address.value = body['data']['address'];
      birthdate.value = body['data']['birthdate'];
    }
  }

  Future<bool> editProfile() async {
    var name = nameTxtController.text;
    var phone = phoneTxtController.text;
    var email = emailTxtController.text;
    var address = addressTxtController.text;
    var birthdate = reverseBirthdate(birthdateTxtController.text);

    try {
      isSubmitting.value = true;

      var response = await APIService.put('/profile', {
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'birthdate': birthdate,
      });

      var body = jsonDecode(response.body);

      if (body['success'] ?? false) {
        final snackBar =
            SnackBarTypes.createSuccessSnackbar('Berhasil mengubah profil.');
        snackbarKey.currentState?.showSnackBar(snackBar);

        await Future.delayed(const Duration(seconds: 1));
        snackbarKey.currentState?.hideCurrentSnackBar();

        await _fetchProfileData();

        return true;
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

    final snackBar = SnackBarTypes.createFailedSnackbar(
      'Terjadi kegagalan saat mengubah Profil.',
    );
    snackbarKey.currentState?.showSnackBar(snackBar);

    return false;
  }

  void pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpeg', 'jpg', 'png'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      _cropImage(file);
    }
  }

  Future<void> _cropImage(File image) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: image.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      aspectRatio: const CropAspectRatio(ratioX: 2, ratioY: 3),
    );

    if (croppedImage != null) {
      // File image = File(croppedImage.path);
      _saveImage(croppedImage);
    }
  }

  void _saveImage(CroppedFile image) async {
    try {
      isSubmitting.value = true;

      var response =
          await APIService.postProfilePicture('/profile-picture', image.path);

      var body = jsonDecode(response.body);

      if (body['success'] ?? false) {
        final snackBar = SnackBarTypes.createSuccessSnackbar(
            'Berhasil mengubah foto profil.');
        snackbarKey.currentState?.showSnackBar(snackBar);

        await _fetchProfileData();
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

  // Todo make this into a service
  static String reverseBirthdate(String birthdate) {
    var split = birthdate.split('-');
    var reversedBirthdate =
        split.reversed.reduce((value, element) => value += element);

    return DateFormat('yyyy-MM-dd').format(DateTime.parse(reversedBirthdate));
  }
}
