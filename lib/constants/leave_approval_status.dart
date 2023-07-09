import 'package:flutter/material.dart';

class LeaveApprovalStatus {
  // Must be the same with app/Constants/ApprovalStatus.php
  static const int pending = 1;
  static const int rejected = 2;
  static const int approved = 3;

  static String getLabel(int id) {
    switch (id) {
      case pending:
        return 'Pending';
      case rejected:
        return 'Ditolak';
      case approved:
        return 'Disetujui';
      default:
        return '-';
    }
  }

  static Color getColor(int id) {
    switch (id) {
      case pending:
        return Colors.orange;
      case rejected:
        return Colors.red;
      case approved:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
