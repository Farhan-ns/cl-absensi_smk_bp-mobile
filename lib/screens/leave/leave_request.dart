import 'package:absensi_smk_bp/components/appbar.dart';
import 'package:absensi_smk_bp/components/button.dart';
import 'package:absensi_smk_bp/components/button_circular_progress.dart';
import 'package:absensi_smk_bp/components/button_label.dart';
import 'package:absensi_smk_bp/components/textfield.dart';
import 'package:absensi_smk_bp/constants/leave_category.dart';
import 'package:absensi_smk_bp/controllers/leave_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LeaveRequestScreen extends StatefulWidget {
  // leaveCategoryId must be from LeaveCategory Class
  const LeaveRequestScreen(this.leaveCategoryId, {super.key});

  final int leaveCategoryId;

  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  late String leaveLabel;
  final LeaveController controller = Get.find();

  @override
  void initState() {
    super.initState();

    leaveLabel = LeaveCategory.getLabel(widget.leaveCategoryId);
    controller.leaveCategoryId = widget.leaveCategoryId;
  }

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
                  leaveLabel,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  'Nama Lengkap',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 5),
                Obx(
                  () => MyTextField(
                    textInputType: TextInputType.text,
                    enabled: false,
                    controller: TextEditingController(
                      text: controller.teacherName.string,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Alasan Izin',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 5),
                MyTextField(
                  textInputType: TextInputType.text,
                  controller: controller.absenceReasonTextController,
                ),
                const SizedBox(height: 12),
                Text(
                  'Tanggal',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dari Tanggal',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            readOnly: true,
                            controller: controller.fromDateTextController,
                            decoration: InputDecoration(
                              isDense: true,
                              suffixIcon: const Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
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
                                locale: const Locale('id', 'ID'),
                              );

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                controller.fromDateTextController.text =
                                    formattedDate;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sampai Tanggal',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            readOnly: true,
                            controller: controller.toDateTextController,
                            decoration: InputDecoration(
                              isDense: true,
                              suffixIcon: const Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
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
                                locale: const Locale('id', 'ID'),
                              );

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                controller.toDateTextController.text =
                                    formattedDate;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Keterangan',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 5),
                MyTextField(
                  heightSpan: 5,
                  controller: controller.absenceNoteTextController,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyElevatedButton(
                      context,
                      const ButtonLabel('Upload File'),
                      onPressed: () => controller.pickFile(),
                    ),
                    Obx(
                      () => Text(controller.selectedFilename.string),
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
                          () => controller.isSubmitting.isTrue
                              ? const ButtonCircularProgress()
                              : const ButtonLabel('Simpan'),
                        ),
                        onPressed: () {
                          if (controller.isSubmitting.isTrue) return;
                          controller.handleSubmit();
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
