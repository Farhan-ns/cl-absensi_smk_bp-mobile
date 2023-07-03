import 'package:absensi_smk_bp/components/appbar.dart';
import 'package:absensi_smk_bp/components/button_circular_progress.dart';
import 'package:absensi_smk_bp/components/button_icon.dart';
import 'package:absensi_smk_bp/components/button_label.dart';
import 'package:absensi_smk_bp/components/info_chip.dart';
import 'package:absensi_smk_bp/components/menu_icon_text.dart';
import 'package:absensi_smk_bp/components/status_chip.dart';
import 'package:absensi_smk_bp/constants/leave_category.dart';
import 'package:absensi_smk_bp/controllers/attendance_controller.dart';
import 'package:absensi_smk_bp/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final AttendanceController attendanceController =
      Get.put(AttendanceController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();

    attendanceController.fetchTodaysAttendance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: MyAppBar(),
      ),
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
                    date: 'Permohonan anda sedang diproses',
                    // date: 'Selasa, 23-05-2023',
                    child: SizedBox.shrink(),
                    // child: Wrap(
                    //   children: [
                    //     Text(
                    //       'Selasa, 23-05-2023',
                    //       style: TextStyle(color: Colors.blue),
                    //     ),
                    //   ],
                    // ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Obx(
                () => RichText(
                  text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.normal),
                    text: 'Halo, ',
                    children: [
                      TextSpan(
                        text: profileController.name.string,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => Column(
                  children: [
                    if (attendanceController.isFetching.isTrue) ...[
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ] else ...[
                      if (attendanceController.connectionError.isTrue) ...[
                        const ErrorAttendanceCard(),
                      ] else if (attendanceController.hasCheckinToday.isTrue &&
                          attendanceController.hasCheckoutToday.isTrue) ...[
                        const CompleteAttendanceCard(),
                      ] else if (attendanceController.hasCheckinToday.isTrue &&
                          attendanceController.hasCheckoutToday.isFalse) ...[
                        CheckoutCard(attendanceController),
                      ] else if (attendanceController
                          .hasCheckinToday.isFalse) ...[
                        CheckinCard(attendanceController),
                      ] else ...[
                        const Text('Something went wrong'),
                      ]
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Fitur',
                style: Theme.of(context).textTheme.titleMedium,
              ),
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
                    text: 'Izin \nSakit',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'History',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Recently'),
                  InkWell(
                    onTap: () {},
                    child: const Row(
                      children: [
                        Text(
                          'Lihat Semua',
                          style: TextStyle(color: Colors.blue),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: const InfoChip(
                  image: 'assets/images/ian.jpg',
                  name: 'Rendra Muhammad',
                  date: 'Selasa, 23-05-2023',
                  child: StatusChip(
                    leaveCategory: LeaveCategory.officialLeave,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: const InfoChip(
                  image: 'assets/images/ian.jpg',
                  name: 'Rendra Muhammad',
                  date: 'Selasa, 23-05-2023',
                  child: StatusChip(
                    leaveCategory: LeaveCategory.officialLeave,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: const InfoChip(
                  image: 'assets/images/ian.jpg',
                  name: 'Rendra Muhammad',
                  date: 'Selasa, 23-05-2023',
                  child: StatusChip(
                    leaveCategory: LeaveCategory.officialLeave,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CompleteAttendanceCard extends StatelessWidget {
  const CompleteAttendanceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Card(
      color: Color(0xFFfafafa),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Anda sudah absen pulang.',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Image(
                image: AssetImage('assets/images/hand-phone.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutCard extends StatelessWidget {
  const CheckoutCard(
    this.controller, {
    super.key,
  });

  final AttendanceController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFfafafa),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Anda sudah di sekolah',
                  style: TextStyle(color: Colors.green),
                ),
                const SizedBox(height: 20),
                MyElevatedButtonIcon(
                  Obx(
                    () => controller.isSubmitting.isTrue
                        ? const ButtonCircularProgress()
                        : const ButtonLabel('Absen Pulang'),
                  ),
                  const Icon(Icons.check),
                  color: Colors.green,
                  onPressed: () => controller.checkout(),
                )
              ],
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Image(
                image: AssetImage('assets/images/hand-phone.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckinCard extends StatelessWidget {
  const CheckinCard(
    this.controller, {
    super.key,
  });

  final AttendanceController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                MyElevatedButtonIcon(
                  Obx(
                    () => controller.isSubmitting.isTrue
                        ? const ButtonCircularProgress()
                        : const ButtonLabel('Absen Sekarang'),
                  ),
                  const Icon(Icons.exit_to_app),
                  onPressed: () => controller.checkin(),
                )
              ],
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Image(
                image: AssetImage('assets/images/hand-phone.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ErrorAttendanceCard extends StatelessWidget {
  const ErrorAttendanceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red.shade800,
      child: const Row(
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Tidak Dapat Menjangkau server.',
            ),
          )
        ],
      ),
    );
  }
}
