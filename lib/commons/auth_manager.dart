import 'package:hive_flutter/adapters.dart';

class AuthManager {
  static Future<String> getToken() async {
    Box authBox = await _getAuthBox();
    String token = authBox.get('token') ?? '';
    return token;
  }

  static void addToken(String token) async {
    Box authBox = await _getAuthBox();
    authBox.put('token', token);
  }

  static Future<void> removeToken() async {
    Box authBox = await _getAuthBox();
    authBox.delete('token');
  }

  static Future<bool> hasToken() async {
    String token = await getToken();
    return token.isNotEmpty;
  }

  static Future<Box> _getAuthBox() async {
    var boxName = 'authorization';
    bool authBoxIsOpen = Hive.isBoxOpen(boxName);
    Box authBox =
        authBoxIsOpen ? Hive.box(boxName) : await Hive.openBox(boxName);
    return authBox;
  }
}
