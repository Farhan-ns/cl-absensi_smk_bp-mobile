import 'package:absensi_smk_bp/commons/api_service.dart';
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

  @HiveField(6)
  String? profilePicture;

  String get getprofilePicture {
    if (profilePicture == null) {
      return 'assets/images/blank_user.png';
    }

    Uri url = Uri.https(APIService.baseUrl, '/profile_pictures/teachers');
    return "$url/$profilePicture";
  }
}
