import 'package:absensi_smk_bp/components/appbar.dart';
import 'package:absensi_smk_bp/components/info_chip.dart';
import 'package:absensi_smk_bp/components/status_chip.dart';
import 'package:absensi_smk_bp/constants/leave_category.dart';
import 'package:flutter/material.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  @override
  void initState() {
    print('HISTORY TAB');

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                'History',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
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
                    leaveCategory: LeaveCategory.personalLeave,
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
                    leaveCategory: LeaveCategory.otherLeave,
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
                    leaveCategory: LeaveCategory.sickLeave,
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
