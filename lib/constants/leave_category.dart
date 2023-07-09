import 'package:flutter/material.dart';

class LeaveCategory {
  // Must be the same with app/Constants/LeaveType.php
  static const int ptoLeave = 3;
  static const int sickLeave = 4;
  static const int officialLeave = 5;
  static const int otherLeave = 6;

  static String getLabel(int leaveCategoryId) {
    switch (leaveCategoryId) {
      case ptoLeave:
        return leaveMap.keys.elementAt(1);
      case sickLeave:
        return leaveMap.keys.elementAt(3);
      case officialLeave:
        return leaveMap.keys.elementAt(0);
      case otherLeave:
        return leaveMap.keys.elementAt(2);
      default:
        return 'Something went wrong when fetching keys';
    }
  }

  static Color? getColor(int leaveCategoryId) {
    switch (leaveCategoryId) {
      case ptoLeave:
        return leaveMap.values.elementAt(1);
      case sickLeave:
        return leaveMap.values.elementAt(3);
      case officialLeave:
        return leaveMap.values.elementAt(0);
      case otherLeave:
        return leaveMap.values.elementAt(2);
      default:
        return null;
    }
  }

  static final Map<String, Color> leaveMap = {
    'Pengajuan Dinas': Colors.blue.shade700,
    'Cuti Kehadiran': Colors.yellow.shade800,
    'Ijin Kehadiran': Colors.green.shade700,
    'Ijin Sakit': Colors.red.shade800,
  };
}
