import 'package:hive_flutter/hive_flutter.dart';

part 'profile_hive_model.g.dart';

@HiveType(typeId: 0)
class ProfileHiveModel extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String birthdate;

  @HiveField(3)
  late String phone;

  @HiveField(4)
  late String email;

  @HiveField(5)
  late String address;
}
