import 'package:absensi_smk_bp/commons/api_service.dart';
import 'package:absensi_smk_bp/commons/box_manager.dart';
import 'package:absensi_smk_bp/components/appbar.dart';
import 'package:absensi_smk_bp/components/status_chip.dart';
import 'package:absensi_smk_bp/constants/leave_approval_status.dart';
import 'package:absensi_smk_bp/controllers/leave_controller.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:absensi_smk_bp/controllers/profile_controller.dart';
import 'package:absensi_smk_bp/hive_models/profile_hive_model.dart';
import 'package:absensi_smk_bp/models/leave.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveHistoryDetailScreen extends StatefulWidget {
  const LeaveHistoryDetailScreen({super.key, required this.leave});

  final Leave leave;

  @override
  State<LeaveHistoryDetailScreen> createState() =>
      _LeaveHistoryDetailScreenState();
}

class _LeaveHistoryDetailScreenState extends State<LeaveHistoryDetailScreen> {
  final ProfileController controller = Get.find();
  final LeaveController leaveController = Get.find();
  Map<String, String> bearerHeader = {};
  String teacherName = '';
  bool absenceDocIsImage = false;

  @override
  void initState() {
    super.initState();

    APIService.initHeaders().then((value) {
      setState(() {
        bearerHeader = value;
      });
    });

    BoxManager.getBox('profile').then((box) {
      var profile = box.get('profile') as ProfileHiveModel;

      setState(() {
        teacherName = profile.name;
      });
    });

    leaveController.fetchAbsenceDocTypeIsImage(widget.leave.id).then((value) {
      setState(() {
        absenceDocIsImage = value;
      });
    });
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          controller.profile.value.profilePicture != null
                              ? CachedNetworkImageProvider(
                                  controller.profile.value.getprofilePicture,
                                )
                              : AssetImage(
                                  controller.profile.value.getprofilePicture,
                                ) as ImageProvider,
                      // AssetImage('assets/images/blank_user.png'),
                      radius: 27,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            teacherName,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.leave.formattedDate,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Status',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            LeaveApprovalStatus.getLabel(
                                widget.leave.approvalStatus),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: LeaveApprovalStatus.getColor(
                                      widget.leave.approvalStatus),
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Alasan Izin',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                StatusChip(leaveCategory: widget.leave.leaveType),
                const SizedBox(height: 20),
                Text(
                  'Tanggal Izin',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.event,
                      color: Colors.grey.shade700,
                    ),
                    Text(
                      widget.leave.formattedRangeDate,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Keterangan Izin',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.leave.absenceNote,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 20),
                Text(
                  'Surat Izin',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                absenceDocIsImage
                    ? Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          FullScreenWidget(
                            disposeLevel: DisposeLevel.Low,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: CachedNetworkImage(
                                imageUrl: widget.leave.docUrl,
                                httpHeaders: bearerHeader,
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.leave.absenceDocument,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : Card(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.leave.absenceDocument,
                            style: const TextStyle(
                              color: Colors.white,
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
