// To parse this JSON data, do
//
//     final notificationData = notificationDataFromJson(jsonString);

import 'dart:convert';

NotificationData notificationDataFromJson(String str) =>
    NotificationData.fromJson(json.decode(str));

String notificationDataToJson(NotificationData data) =>
    json.encode(data.toJson());

class NotificationData {
  int leaveId;
  String message;
  String date;

  NotificationData({
    required this.leaveId,
    required this.message,
    required this.date,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        leaveId: json["leave_id"],
        message: json["message"] ?? '-',
        date: json["date"] ?? '-',
      );

  Map<String, dynamic> toJson() => {
        "leave_id": leaveId,
        "message": message,
        "date": date,
      };
}
