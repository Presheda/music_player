
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_exoplayer/audioplayer.dart';

abstract class PlayerService{


  Future<dynamic> playSong(String url);

  Future<dynamic> playAll();

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

 SongInfo getCurrentSong();


}