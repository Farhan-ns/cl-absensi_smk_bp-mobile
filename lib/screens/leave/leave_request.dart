import 'package:absensi_smk_bp/components/appbar.dart';
import 'package:absensi_smk_bp/components/button.dart';
import 'package:absensi_smk_bp/components/button_label.dart';
import 'package:absensi_smk_bp/components/textfield.dart';
import 'package:flutter/material.dart';

class LeaveRequestScreen extends StatelessWidget {
  const LeaveRequestScreen({super.key});

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
                const Text('Pengajuan Dinas'),
                const SizedBox(height: 20),
                const Text('Nama Lengkap'),
                const SizedBox(height: 5),
                MyTextField(
                  textInputType: TextInputType.text,
                  controller: TextEditingController(),
                ),
                const SizedBox(height: 12),
                const Text('Alasan Izin'),
                const SizedBox(height: 5),
                MyTextField(
                  textInputType: TextInputType.text,
                  controller: TextEditingController(),
                ),
                const SizedBox(height: 12),
                const Text('Tanggal'),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Dari Tanggal'),
                          const SizedBox(height: 5),
                          MyTextField(
                            textInputType: TextInputType.text,
                            controller: TextEditingController(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Sampai Tanggal'),
                          const SizedBox(height: 5),
                          MyTextField(
                            textInputType: TextInputType.text,
                            controller: TextEditingController(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text('Keterangan'),
                const SizedBox(height: 5),
                MyTextField(
                  heightSpan: 5,
                  controller: TextEditingController(),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyElevatedButton(
                      context,
                      const ButtonLabel('Upload File'),
                      onPressed: () {},
                    ),
                    const Text('img-surat-dinas.jpg'),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: MyElevatedButton(
                        context,
                        const ButtonLabel('Simpan'),
                        onPressed: () {},
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
