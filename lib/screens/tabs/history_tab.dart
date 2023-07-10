import 'package:absensi_smk_bp/components/appbar.dart';
import 'package:absensi_smk_bp/components/info_chip.dart';
import 'package:absensi_smk_bp/components/status_chip.dart';
import 'package:absensi_smk_bp/controllers/leave_controller.dart';
import 'package:absensi_smk_bp/controllers/profile_controller.dart';
import 'package:absensi_smk_bp/models/leave.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  final LeaveController leaveController = Get.find();
  final ProfileController profileController = Get.find();
  // final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: MyAppBar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  'History',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 18),
                Obx(
                  () => Column(
                    children: [
                      for (Leave leave in leaveController.leaveList)
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
    );
  }
}
