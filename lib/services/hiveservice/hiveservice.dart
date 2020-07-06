
import 'dart:async';

import 'package:hive/hive.dart';

abstract class HiveService {

  Future<Box<dynamic>> openBox (String boxName);

  Future<Box<dynamic>> getBox(String boxName);



}