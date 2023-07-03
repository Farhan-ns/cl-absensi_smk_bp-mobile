import 'package:absensi_smk_bp/hive_models/profile_hive_model.dart';

class HiveModelService {
  static ProfileHiveModel makeHiveProfileModel(dynamic user) =>
      ProfileHiveModel()
        ..id = user['id']
        ..name = user['name']
        ..email = user['email']
        ..birthdate = user['birthdate']
        ..phone = user['phone']
        ..address = user['address'];
}
