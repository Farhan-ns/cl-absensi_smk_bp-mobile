import 'package:absensi_smk_bp/components/appbar.dart';
import 'package:absensi_smk_bp/components/info_chip.dart';
import 'package:absensi_smk_bp/components/status_chip.dart';
import 'package:absensi_smk_bp/constants/leave_category.dart';
import 'package:flutter/material.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'History'),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('History'),
              InfoChip(
                image: 'assets/images/ian.jpg',
                name: 'Rendra Muhammad',
                date: 'Selasa, 23-05-2023',
                child: StatusChip(
                  leaveCategory: LeaveCategory.officialLeave,
                ),
              ),
              InfoChip(
                image: 'assets/images/ian.jpg',
                name: 'Rendra Muhammad',
                date: 'Selasa, 23-05-2023',
                child: StatusChip(
                  leaveCategory: LeaveCategory.personalLeave,
                ),
              ),
              InfoChip(
                image: 'assets/images/ian.jpg',
                name: 'Rendra Muhammad',
                date: 'Selasa, 23-05-2023',
                child: StatusChip(
                  leaveCategory: LeaveCategory.otherLeave,
                ),
              ),
              InfoChip(
                image: 'assets/images/ian.jpg',
                name: 'Rendra Muhammad',
                date: 'Selasa, 23-05-2023',
                child: StatusChip(
                  leaveCategory: LeaveCategory.sickLeave,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
