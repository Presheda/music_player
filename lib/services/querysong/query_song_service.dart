
import 'package:flutter_audio_query/flutter_audio_query.dart';

abstract class QuerySongService {

  Future<List<SongInfo>> songList();

}