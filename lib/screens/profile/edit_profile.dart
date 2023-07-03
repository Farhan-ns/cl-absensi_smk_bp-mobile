import 'package:absensi_smk_bp/components/appbar.dart';
import 'package:absensi_smk_bp/components/button.dart';
import 'package:absensi_smk_bp/components/button_circular_progress.dart';
import 'package:absensi_smk_bp/components/button_label.dart';
import 'package:absensi_smk_bp/components/textfield.dart';
import 'package:absensi_smk_bp/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

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
                  'Edit Profil',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        const CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage('assets/images/ian.jpg'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(8),
                            backgroundColor: Colors.blue, // <-- Button color
                            foregroundColor: Colors.red, // <-- Splash color
                          ),
                          child:
                              const Icon(Icons.camera_alt, color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  'Nama Lengkap',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 5),
                MyTextField(
                  textInputType: TextInputType.text,
                  controller: controller.nameTxtController,
                ),
                const SizedBox(height: 12),
                Text(
                  'Nomor Telepon',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 5),
                MyTextField(
                  textInputType: TextInputType.phone,
                  controller: controller.phoneTxtController,
                ),
                const SizedBox(height: 12),
                Text(
                  'Email',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 5),
                MyTextField(
                  textInputType: TextInputType.emailAddress,
                  controller: controller.emailTxtController,
                ),
                const SizedBox(height: 12),
                Text(
                  'Tanggal Lahir',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 5),
                TextField(
                  readOnly: true,
                  controller: controller.birthdateTxtController,
                  decoration: InputDecoration(
                    isDense: true,
                    suffixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                      gapPadding: 9,
                    ),
                  ),
                  onTap: () async {
                    var date = DateTime.now();
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(1953),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      controller.birthdateTxtController.text = formattedDate;
                    }
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  'Alamat Rumah',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 5),
                MyTextField(
                  textInputType: TextInputType.datetime,
                  controller: controller.addressTxtController,
                ),
                const SizedBox(height: 12),
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
                          var success = await controller.editProfile();
                          if (success && context.mounted) context.pop();
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
