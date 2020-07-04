import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:music_player/services/playerservice/player_service.dart';

class PlayerServiceImpl implements PlayerService {
  var player = AudioPlayer();


  @override
  Future next() {
   return player.next();
  }

  @override
  Future pauseSong() {
    return player.pause();
  }

  @override
  Future playSong(String url) async {
    if (player.state == PlayerState.PLAYING) {
      await player.stop();
    }

    await player.release();

   return player.play(url);
  }

  @override
  Future playAll(List<String> url) async {

    print("play all called");
    print(url);

    if (player.state == PlayerState.PLAYING) {
      await player.stop();
    }

    await player.release();
    return player.playAll(url);
  }

  @override
  Future previous() {

   return player.previous();
  }

  @override
  Future resumeSong() {
    // TODO: implement resumeSong
    throw UnimplementedError();
  }

  @override
  Future seek() {
    // TODO: implement seek
    throw UnimplementedError();
  }

  @override
  Stream<Duration> duration() {
    return player.onDurationChanged;
  }

   void audioPosition() {

     player.onAudioPositionChanged.listen((event) {

       print("AudioPosition is ${event.inSeconds}");

    });
  }

  @override
  void playerState() {



    player.onPlayerStateChanged.listen((event) {
      print("PlayerState changed");
    });

  }


}
