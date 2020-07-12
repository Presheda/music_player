
import 'dart:async';

import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:get/get.dart';
import 'package:music_player/model/HiveSongInfo.dart';
import 'package:music_player/services/locator.dart';
import 'package:music_player/services/playerservice/player_service.dart';
import 'package:music_player/services/querysong/query_song_service.dart';

class AllSongViewModel extends GetxController {
  var playerService = getIt<PlayerService>();
  var queryService = getIt<QuerySongService>();

  List<SongInfo> songList;

  StreamSubscription<int> audioIndex;
  StreamSubscription<PlayerState> state;

  int currentAudioIndex;

  bool isPaused = false;
  bool isPlaying = false;


  String currentUrl ="";

  AllSongViewModel(){
    addSubSubscription();

    fetchSong();

    getCurrentSongUrl();
    playerStateChanged(playerService.getPlayerState());
  }

  void fetchSong() {
    songList = queryService.songList();
    print("Song Size is ${songList.length}");
  }

  void getCurrentSongUrl() async{
    HiveSongInfo songInfo = await playerService.getCurrentSong();
    currentUrl = songInfo.url;
    update(["updateIcons"]);
  }


  void playSong(int index){

    playerService.playAll( index: index);

  }

  void playPause(){
    if(isPlaying){
      playerService.pauseSong();

      return;
    }

    if(isPaused){
      playerService.resumeSong();
    }


  }

  void playerStateChanged(PlayerState state) {
    print("State Changed");
    isPaused = state == PlayerState.PAUSED;
    isPlaying = state == PlayerState.PLAYING;
    update(["updateIcons"]);
  }


  addSubSubscription(){
    state = playerService.playerState().listen((event) {
      playerStateChanged(event);
    });

    audioIndex = playerService.audioIndex().listen((event) {
      currentAudioIndex = event;
      getCurrentSongUrl();
      print("Audio Index Changed $event");

     // audioInfo();
    });
  }

  @override
  void onClose() {
    state?.cancel();
    audioIndex?.cancel();

    super.onClose();
  }


}