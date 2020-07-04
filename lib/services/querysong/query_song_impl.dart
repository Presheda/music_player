


import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_player/services/locator.dart';
import 'package:music_player/services/querysong/query_song_service.dart';

class QuerySongServiceImpl implements QuerySongService {

  FlutterAudioQuery audioQuery = getIt<FlutterAudioQuery>();

  @override
  Future<List<SongInfo>> songList() async {

    //List<SongInfo> songs = await audioQuery.getSongs();

    return audioQuery.getSongs();

  }



}
