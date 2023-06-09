import 'package:absensi_smk_bp/components/appbar.dart';
import 'package:absensi_smk_bp/components/info_chip.dart';
import 'package:absensi_smk_bp/components/status_chip.dart';
import 'package:absensi_smk_bp/constants/leave_category.dart';
import 'package:flutter/material.dart';

class AttendanceHistoryDetailScreen extends StatelessWidget {
  const AttendanceHistoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'History Detail'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Detail History'),
              const SizedBox(height: 20),
              const InfoChip(
                image: 'assets/images/ian.jpg',
                name: 'Rendra Muhammad',
                date: 'Selasa, 23-05-2023',
                child: Column(
                  children: [
                    Text('Status'),
                    Text(
                      'Approved',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Alasan Izin'),
              const SizedBox(height: 6),
              const StatusChip(leaveCategory: LeaveCategory.officialLeave),
              const SizedBox(height: 20),
              const Text('Tanggal Izin'),
              const SizedBox(height: 6),
              const Row(
                children: [
                  Icon(
                    Icons.event,
                    color: Colors.grey,
                  ),
                  Text(
                    '25 Mei - 30 Mei 2023',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Keterangan Izin'),
              const SizedBox(height: 6),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam rutrum odio elit, sit amet semper erat cursus id. Proin sapien libero, viverra eu pretium at, varius eget neque. Praesent finibus, sem sit amet venenatis sollicitudin, arcu diam porttitor lacus, sit amet maximus risus orci varius ante.',
              ),
              const SizedBox(height: 20),
              const Text('Surat Izin'),
              const SizedBox(height: 6),
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      'assets/images/surat_izin.jpeg',
                    ),
                  ),
                  const Card(
                    color: Colors.black,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'surat_dinas.jpeg',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
