import 'package:absensi_smk_bp/components/appbar.dart';
import 'package:absensi_smk_bp/components/button.dart';
import 'package:absensi_smk_bp/components/textfield.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Edit Profil'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Edit Profil'),
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
                const Text('Nama Lengkap'),
                const SizedBox(height: 5),
                MyTextField(textInputType: TextInputType.text),
                const SizedBox(height: 12),
                const Text('Nomor Telepon'),
                const SizedBox(height: 5),
                MyTextField(textInputType: TextInputType.phone),
                const SizedBox(height: 12),
                const Text('Email'),
                const SizedBox(height: 5),
                MyTextField(textInputType: TextInputType.emailAddress),
                const SizedBox(height: 12),
                const Text('Tanggal Lahir'),
                const SizedBox(height: 5),
                MyTextField(textInputType: TextInputType.datetime),
                const SizedBox(height: 12),
                const Text('Alamat Rumah'),
                const SizedBox(height: 5),
                MyTextField(
                  textInputType: TextInputType.text,
                  heightSpan: 3,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: MyElevatedButton(
                        context,
                        'Simpan',
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
