
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:music_player/model/HiveSongInfo.dart';

abstract class PlayerService{


  Future<dynamic> playSong(String url);

  Future<dynamic> playAll({int index});

  Future<dynamic> playPlaylist(String playListName);

  Future<dynamic> pauseSong();

  Future<dynamic> resumeSong();

  Future<dynamic> previous();

  Future<dynamic> next();

  Future<dynamic> seek(double position);

  Stream<Duration> duration();

  Stream<Duration> audioPosition();

 Stream<PlayerState>  playerState();

 Future<Duration> getCurrentDuration();

 Stream<int> audioIndex();

 Future<HiveSongInfo> getCurrentSong();

 PlayerState getPlayerState();

}