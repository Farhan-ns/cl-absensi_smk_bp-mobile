import 'package:absensi_smk_bp/commons/box_manager.dart';
import 'package:absensi_smk_bp/commons/globals.dart';
import 'package:absensi_smk_bp/components/appbar.dart';
import 'package:absensi_smk_bp/components/button_circular_progress.dart';
import 'package:absensi_smk_bp/components/button_icon.dart';
import 'package:absensi_smk_bp/components/button_label.dart';
import 'package:absensi_smk_bp/components/info_chip.dart';
import 'package:absensi_smk_bp/components/menu_icon_text.dart';
import 'package:absensi_smk_bp/components/notif_info_chip.dart';
import 'package:absensi_smk_bp/components/status_chip.dart';
import 'package:absensi_smk_bp/constants/leave_category.dart';
import 'package:absensi_smk_bp/controllers/attendance_controller.dart';
import 'package:absensi_smk_bp/controllers/leave_controller.dart';
import 'package:absensi_smk_bp/controllers/notification_controller.dart';
import 'package:absensi_smk_bp/controllers/profile_controller.dart';
import 'package:absensi_smk_bp/hive_models/profile_hive_model.dart';
import 'package:absensi_smk_bp/models/leave.dart';
import 'package:absensi_smk_bp/screens/tabs/history_tab.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final AttendanceController attendanceController =
      Get.put(AttendanceController());
  final ProfileController profileController = Get.put(ProfileController());
  final LeaveController leaveController = Get.put(LeaveController());
  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  void initState() {
    super.initState();

    leaveController.fetchLeavesHistory();
    attendanceController.fetchTodaysAttendance();
    notificationController.fetchNotifications();

    BoxManager.getBox('profile').then((box) {
      ProfileHiveModel profile = box.get('profile') as ProfileHiveModel;
      leaveController.teacherName.value = profile.name;
    });
  }

  Future<void> _refresh() async {
    leaveController.fetchLeavesHistory();
    attendanceController.fetchTodaysAttendance();
    notificationController.fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: MyAppBar.notification(),
      ),
      endDrawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Text(
                          'Notifikasi',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  for (var notification
                      in notificationController.notificationList)
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: NotifInfoChip(
                        imageProvider:
                            profileController.profile.value.profilePicture !=
                                    null
                                ? CachedNetworkImageProvider(
                                    profileController
                                        .profile.value.getprofilePicture,
                                  )
                                : AssetImage(
                                    profileController
                                        .profile.value.getprofilePicture,
                                  ) as ImageProvider,
                        name: leaveController.teacherName.string,
                        date: notification.date,
                        text: notification.message,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: () => _refresh(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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
                          ] else if (attendanceController
                                  .hasCheckinToday.isTrue &&
                              attendanceController.hasCheckoutToday.isTrue) ...[
                            const CompleteAttendanceCard(),
                          ] else if (attendanceController
                                  .hasCheckinToday.isTrue &&
                              attendanceController
                                  .hasCheckoutToday.isFalse) ...[
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
                    // style: TextStyle(fontWeight: FontWeight.bold),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    children: [
                      MenuIconText(
                        image: 'assets/images/checklist.png',
                        text: 'Pengajuan Dinas',
                        callback: () {
                          context.push(
                            '/leave-request',
                            extra: LeaveCategory.officialLeave,
                          );
                        },
                      ),
                      MenuIconText(
                        image: 'assets/images/absence.png',
                        text: 'Izin Kehadiran',
                        callback: () {
                          context.push(
                            '/leave-request',
                            extra: LeaveCategory.otherLeave,
                          );
                        },
                      ),
                      MenuIconText(
                        image: 'assets/images/leave.png',
                        text: 'Cuti Kehadiran',
                        callback: () {
                          context.push(
                            '/leave-request',
                            extra: LeaveCategory.ptoLeave,
                          );
                        },
                      ),
                      MenuIconText(
                        image: 'assets/images/sick.png',
                        text: 'Izin \nSakit',
                        callback: () {
                          context.push(
                            '/leave-request',
                            extra: LeaveCategory.sickLeave,
                          );
                        },
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
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const HistoryTab(),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
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
                  Obx(
                    () => Column(
                      children: [
                        for (Leave leave in leaveController.leaveList.take(3))
                          InkWell(
                            onTap: () {
                              if (context.mounted) {
                                context.push('/leave-history-detail',
                                    extra: leave);
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: InfoChip(
                                imageProvider: profileController
                                            .profile.value.profilePicture !=
                                        null
                                    ? CachedNetworkImageProvider(
                                        profileController
                                            .profile.value.getprofilePicture,
                                      )
                                    : AssetImage(
                                        profileController
                                            .profile.value.getprofilePicture,
                                      ) as ImageProvider,
                                name: leaveController.teacherName.string,
                                date: leave.formattedDate,
                                child: StatusChip(
                                  leaveCategory: leave.leaveType,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
