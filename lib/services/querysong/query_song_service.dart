
import 'package:flutter_audio_query/flutter_audio_query.dart';

abstract class QuerySongService {

  List<SongInfo> songList();

  List<SongInfo> playListFavorites();

  List<String> url();

  void addPlayListFavorite(List<SongInfo> song);

  void refresh();


}