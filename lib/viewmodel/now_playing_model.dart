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
  double totalDuration = 100;
  double _currentTime = 100;

  double get currentTime => _currentTime;

  int currentIndex = 0;



  bool _isPaused = false;
  bool _isPlaying = false;
  StreamSubscription<Duration> duration;
  StreamSubscription<PlayerState> state;
  StreamSubscription<int> audioIndex;

  String songTitle = "";
  String songDisplayName = "";
  String songArtist = "";

  void play() async {
    if (_isPlaying) {
      playerService.pauseSong();
      return;
    }

    if (_isPaused) {
      playerService.resumeSong();
      return;
    }


    playerService.playAll();
  }

  bool isPlaying() {
    return _isPlaying;
  }

  @override
  void onInit() {
    addSubscriptions();

    super.onInit();
  }

  void previous() {
    playerService.previous();
  }

  void next() {
    playerService.next();
  }

  void audioInfo() {


    print("AudioIndex 2");

    SongInfo songInfo = playerService.getCurrentSong();

    totalDuration = double.tryParse(songInfo.duration);
    totalDuration = (totalDuration / 1000);

    songTitle = songInfo.title;

    songDisplayName = songInfo.displayName;
    songArtist = songInfo.artist;

    update(["slider", "songInfo", "songDuration"]);
  }

  String formatCurrentDuration() {
    if ( _currentTime == 0) return "0:00";

    final String minutes =
        ((_currentTime / 60) % 60).floor().toString().padLeft(2, '0');
    String seconds = (_currentTime % 60).floor().toString().padLeft(2, '0');

    return "$minutes:$seconds";
  }

  String formatTotalDuration() {
    if (totalDuration == 0 ) return "0:00";

    final String minutes =
        ((totalDuration / 60) % 60).floor().toString().padLeft(2, '0');
    String seconds = (totalDuration % 60).floor().toString().padLeft(2, '0');

    return "$minutes:$seconds";
  }

  void addSubscriptions() async {
    duration = playerService.audioPosition().listen((event) {
      _currentTime = event.inSeconds.toDouble();

      update(["slider", "songDuration"]);
    });

    state = playerService.playerState().listen((event) {
      playerStateChanged(event);
    });

    audioIndex = playerService.audioIndex().listen((event) {
      currentIndex = event;
      audioInfo();
    });
  }

  void seek(double position){
    playerService.seek(position);
  }

  void playerStateChanged(PlayerState state) {
    _isPaused = state == PlayerState.PAUSED;
    _isPlaying = state == PlayerState.PLAYING;
    update(["playControllerButton"]);
  }

  @override
  void onClose() {
    duration?.cancel();
    state?.cancel();
    audioIndex?.cancel();

    super.onClose();
  }
}
