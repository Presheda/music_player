
import 'package:flutter_audio_query/flutter_audio_query.dart';

abstract class QuerySongService {

  List<SongInfo> songList();

  List<String> url();

  void refresh();


}