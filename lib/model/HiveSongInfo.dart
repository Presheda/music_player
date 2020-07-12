
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:hive/hive.dart';

part 'HiveSongInfo.g.dart';

@HiveType(typeId: 3)
class HiveSongInfo extends HiveObject {

  @HiveField(1)
  String title;

  @HiveField(2)
  String artist;

  @HiveField(3)
  String duration;

  @HiveField(4)
  String displayName;

  @HiveField(6)
  String url;

  @HiveField(5)
  int index;



  void mapSong(SongInfo songInfo){
    title = songInfo.title;
    artist = songInfo.artist;
    duration = songInfo.duration;
    displayName =songInfo.displayName;
    url = songInfo.filePath;
  }

}