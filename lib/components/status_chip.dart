import 'package:absensi_smk_bp/constants/leave_category.dart';
import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final int leaveCategory;

  const StatusChip({super.key, required this.leaveCategory});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        LeaveCategory.getLabel(leaveCategory),
        style: const TextStyle(color: Colors.white),
      ),
      side: BorderSide.none,
      backgroundColor: LeaveCategory.getColor(leaveCategory),
    );
  }
}
