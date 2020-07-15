
import 'package:hive/hive.dart';

part 'playlist_model.g.dart';

@HiveType(typeId: 4)
class HivePlaylistModel{

  @HiveField(0)
  String name;

  @HiveField(1)
  List<String> urls;

}