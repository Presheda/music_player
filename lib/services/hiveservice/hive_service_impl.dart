import 'package:hive/hive.dart';
import 'package:hive/src/object/hive_object.dart';
import 'package:music_player/services/hiveservice/hiveservice.dart';

class HiveServiceImpl extends HiveService {
  @override
  Future<Box<dynamic>> openBox(String boxName) async {
    return Hive.openBox(boxName);
  }

  @override
  Future<Box<dynamic>> getBox(String boxName) {
    if (Hive.isBoxOpen(boxName)) {
      return Future.delayed(Duration(milliseconds: 10))
          .then((value) => Hive.box(boxName));
    }

    return Hive.openBox(boxName);
  }
}
