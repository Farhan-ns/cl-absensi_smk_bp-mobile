import 'package:hive_flutter/adapters.dart';

class BoxManager {
  static Future<Box> getBox(String boxName) async {
    bool boxIsOpen = Hive.isBoxOpen(boxName);
    Box box = boxIsOpen ? Hive.box(boxName) : await Hive.openBox(boxName);
    return box;
  }
}
