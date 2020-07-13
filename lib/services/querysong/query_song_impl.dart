


import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_player/services/locator.dart';
import 'package:music_player/services/querysong/query_song_service.dart';

class QuerySongServiceImpl implements QuerySongService {

  FlutterAudioQuery audioQuery = getIt<FlutterAudioQuery>();

  List<SongInfo> songInfo = [];

  List<SongInfo> playListFavorite = [];

  QuerySongServiceImpl (){

    querySong();
  }

  void querySong() async {
    songInfo = await audioQuery.getSongs();
  }

  @override
  List<SongInfo> songList()  {
    return songInfo;
  }

 @override
  List<SongInfo> playListFavorites()  {
    return playListFavorite;
  }

  @override
  void addPlayListFavorite(List<SongInfo> songInfo){
    this.playListFavorite = songInfo;

  }

  @override
  void refresh() {
    querySong();
  }

  @override
  List<String> url() {

    List<String> urls =[];

    songInfo.forEach((element) {
      urls.add(element.filePath);
    });

    return urls;

  }



}
