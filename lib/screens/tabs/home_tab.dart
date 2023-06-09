import 'package:absensi_smk_bp/components/appbar.dart';
import 'package:absensi_smk_bp/components/button.dart';
import 'package:absensi_smk_bp/components/info_chip.dart';
import 'package:absensi_smk_bp/components/menu_icon_text.dart';
import 'package:absensi_smk_bp/components/status_chip.dart';
import 'package:absensi_smk_bp/constants/leave_category.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Home'),
      endDrawer: const Drawer(
        child: Padding(
          padding: EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Column(
            children: [
              Wrap(
                children: [
                  InfoChip(
                    image: 'assets/images/ian.jpg',
                    name: 'Rendra Muhammad',
                    date: 'Selasa, 23-05-2023',
                    child: Text('s'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Halo, Rendra Muhammad'),
              Card(
                color: const Color(0xFFfafafa),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Masuk ke sekolah?'),
                          const SizedBox(height: 20),
                          MyElevatedButton(
                            context,
                            'Absen Sekarang',
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Transform.scale(
                          scale: 1,
                          child: const Image(
                            image: AssetImage('assets/images/hand-phone.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Fitur'),
              const Row(
                children: [
                  MenuIconText(
                    image: 'assets/images/checklist.png',
                    text: 'Pengajuan Dinas',
                  ),
                  MenuIconText(
                    image: 'assets/images/absence.png',
                    text: 'Izin Kehadiran',
                  ),
                  MenuIconText(
                    image: 'assets/images/leave.png',
                    text: 'Cuti Kehadiran',
                  ),
                  MenuIconText(
                    image: 'assets/images/sick.png',
                    text: 'Cuti Kehadiran',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('History'),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recently'),
                  Row(
                    children: [
                      Text(
                        'Edit Profile',
                        style: TextStyle(color: Colors.blue),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const InfoChip(
                image: 'assets/images/ian.jpg',
                name: 'Rendra Muhammad',
                date: 'Selasa, 23-05-2023',
                child: StatusChip(
                  leaveCategory: LeaveCategory.officialLeave,
                ),
              ),
              const InfoChip(
                image: 'assets/images/ian.jpg',
                name: 'Rendra Muhammad',
                date: 'Selasa, 23-05-2023',
                child: StatusChip(
                  leaveCategory: LeaveCategory.officialLeave,
                ),
              ),
              const InfoChip(
                image: 'assets/images/ian.jpg',
                name: 'Rendra Muhammad',
                date: 'Selasa, 23-05-2023',
                child: StatusChip(
                  leaveCategory: LeaveCategory.officialLeave,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
