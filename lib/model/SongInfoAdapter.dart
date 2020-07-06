
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:hive/hive.dart';

part 'SongInfoAdapter.g.dart';

@HiveType(typeId: 1)
class SongInfoAdapter extends HiveObject {

  @HiveField(0)
  SongInfo songInfo;

  SongInfoAdapter();


}