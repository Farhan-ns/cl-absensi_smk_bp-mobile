// To parse this JSON data, do
//
//     final leave = leaveFromJson(jsonString);

import 'dart:convert';

import 'package:absensi_smk_bp/commons/api_service.dart';
import 'package:intl/intl.dart';

Leave leaveFromJson(String str) => Leave.fromJson(json.decode(str));

String leaveToJson(Leave data) => json.encode(data.toJson());

class Leave {
  int id;
  String absenceDocument;
  String absenceNote;
  String absenceReason;
  int approvalStatus;
  int leaveType;
  DateTime fromDate;
  DateTime toDate;
  DateTime createdAt;

  Leave({
    required this.id,
    required this.absenceDocument,
    required this.absenceNote,
    required this.absenceReason,
    required this.approvalStatus,
    required this.leaveType,
    required this.fromDate,
    required this.toDate,
    required this.createdAt,
  });

  String get formattedDate {
    return DateFormat('EEEE, dd-MM-yyyy', 'id_ID').format(createdAt);
  }

  String get formattedRangeDate {
    var from = DateFormat('dd MMMM yyyy', 'id_ID').format(fromDate);
    var to = DateFormat('dd MMMM yyyy', 'id_ID').format(toDate);
    return "$from - $to";
  }

  String get docUrl {
    return Uri.http(APIService.baseUrl, "${APIService.baseApi}/leave/doc/$id")
        .toString();
  }

  factory Leave.fromJson(Map<String, dynamic> json) => Leave(
        id: json["id"],
        absenceDocument: json["absence_document"],
        absenceNote: json["absence_note"],
        absenceReason: json["absence_reason"],
        approvalStatus: json["approval_status"],
        leaveType: json["leave_type"],
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "absence_document": absenceDocument,
        "absence_note": absenceNote,
        "absence_reason": absenceReason,
        "approval_status": approvalStatus,
        "leave_type": leaveType,
        "from_date":
            "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
        "to_date":
            "${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
      };
}
