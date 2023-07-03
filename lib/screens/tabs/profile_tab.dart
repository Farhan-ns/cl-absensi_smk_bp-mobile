import 'package:absensi_smk_bp/components/appbar.dart';
import 'package:absensi_smk_bp/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/login_controller.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({super.key});

  final LoginController loginController = Get.put(LoginController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: MyAppBar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Obx(
            () => profileController.isInitializing.value
                ? const CircularProgressIndicator(
                    color: Colors.blue,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Profil',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(5),
                            bottom: Radius.zero,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/ian.jpg'),
                              ),
                              const SizedBox(width: 25),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(profileController.name.value),
                                  Row(
                                    children: [
                                      const Icon(Icons.phone),
                                      const SizedBox(width: 10),
                                      Text(profileController.phone.value),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.email),
                                      const SizedBox(width: 10),
                                      Text(profileController.email.value),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.blue,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.zero,
                            bottom: Radius.circular(5),
                          ),
                        ),
                        child: InkWell(
                          onTap: () => context.push('/edit-profile'),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Edit Profile',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.account_balance,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('SMK Bina Putra'),
                                        Text(
                                          'Jl. Raya Citapen No. Km. 13, 5, Citapen, Kec. Cihampelas, Kabupaten Bandung Barat, Jawa Barat 40562.',
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Alamat Rumah'),
                                        Text(
                                          profileController.address.value,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: InkWell(
                          onTap: () {
                            var success = loginController.logout();
                            if (success && context.mounted) {
                              context.go('/login');
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.input,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 10),
                                Text('Keluar'),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
