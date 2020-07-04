import 'dart:async';

import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:get/get.dart';
import 'package:music_player/services/locator.dart';
import 'package:music_player/services/playerservice/player_service.dart';
import 'package:music_player/services/querysong/query_song_service.dart';

class NowPlayingViewModel extends GetxController {
  var playerService = getIt<PlayerService>();
  var querySong = getIt<QuerySongService>();

  bool _isPlaying = false;
  StreamSubscription<Duration> duration;
  StreamSubscription<PlayerState> state;

  void play() async {
    List<SongInfo> songs = await querySong.songList();

    List<String> urls = [];

    songs.forEach((element) {
      urls.add(element.filePath);
    });

    playerService.audioPosition();
    playerService.playerState();
    playerService.playAll(urls);

    update();
  }

  bool isPlaying() {
    return _isPlaying;
  }

  @override
  void onInit() {
    super.onInit();
    print("init called");
  }

  void playerStateChanged(PlayerState state) {
    print("PlayerState changed");

    _isPlaying = state == PlayerState.PLAYING;
    update(["slider"]);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
