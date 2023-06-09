import 'package:flutter/material.dart';

class LeaveCategory {
  static const int officialLeave = 0;
  static const int personalLeave = 1;
  static const int otherLeave = 2;
  static const int sickLeave = 3;

  static final Map<String, Color> leaveMap = {
    'Pengajuan Dinas': Colors.blue.shade700,
    'Cuti Kehadiran': Colors.yellow.shade800,
    'Ijin Kehadiran': Colors.green.shade700,
    'Ijin Sakit': Colors.red.shade800,
  };
}
