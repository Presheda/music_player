
import 'dart:async';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:get/get.dart';
import 'package:music_player/model/HiveSongInfo.dart';
import 'package:music_player/services/hiveservice/hiveservice.dart';
import 'package:music_player/services/locator.dart';
import 'package:music_player/services/playerservice/player_service.dart';
import 'package:music_player/services/querysong/query_song_service.dart';
import 'package:music_player/ui/play_list/play_list_dialog.dart';
import 'package:stacked_services/stacked_services.dart';

class AllSongViewModel extends GetxController {
  var playerService = getIt<PlayerService>();
  var queryService = getIt<QuerySongService>();
  var hiveService = getIt<HiveService>();

  var dialogService = getIt<DialogService>();


  List<SongInfo> songList;
  List<String> favUrls = [];

  StreamSubscription<int> audioIndex;
  StreamSubscription<PlayerState> state;

  int currentAudioIndex;

  bool isPaused = false;
  bool isPlaying = false;


  String currentUrl = "";

  String currentPlayListUrl = "";

  AllSongViewModel() {
    addSubSubscription();

    fetchSong();
    fetchFavorite();

    getCurrentSongUrl();
    playerStateChanged(playerService.getPlayerState());
  }

  void fetchSong() {
    songList = queryService.songList();
    print("Song Size is ${songList.length}");
  }

  void fetchFavorite() async {
    var box = await hiveService.openBox("favoriteSongs");


    favUrls = box.get("fav");
    if (favUrls == null) {
      favUrls = [];
    }
    update(["updateIcons"]);
  }

  bool isFavorite(String url) {
    return favUrls.contains(url);
  }

  void saveFavoriteSong(String url) async {
    bool isAdded = favUrls.contains(url);

    if (isAdded) {
      favUrls.remove(url);
    } else {
      favUrls.add(url);
    }
    update(["updateIcons"]);

    var box = await hiveService.openBox("favoriteSongs");


    box.put("fav", favUrls);
  }

  void getCurrentSongUrl() async {
    HiveSongInfo songInfo = await playerService.getCurrentSong();
    currentUrl = songInfo.url;
    update(["updateIcons"]);
  }


  void playSong(int index) {
    playerService.playAll(index: index);
  }

  void playPause() {
    if (isPlaying) {
      playerService.pauseSong();

      return;
    }

    if (isPaused) {
      playerService.resumeSong();
    }
  }

  void playerStateChanged(PlayerState state) {
    print("State Changed");
    isPaused = state == PlayerState.PAUSED;
    isPlaying = state == PlayerState.PLAYING;
    update(["updateIcons"]);
  }


  addSubSubscription() {
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

  void playListSelected(String name) async {

    if(Get.isDialogOpen){
      Get.back();
    }

    var playListBox = await hiveService.getBox("playList");

    List<String> playList = playListBox.get(name);

    playList.add(currentPlayListUrl);

    playListBox.put(name, playList);

  }

  void addToPlayList(String url) async {


    var playListBox = await hiveService.openBox("playList");


    List<String> names = playListBox.get("playListNames");

    currentPlayListUrl = url;

    if(names == null || names.isEmpty){

      await dialogService.showDialog(
          title: "Empty",
          description: "No Playlist found",
          buttonTitle: "Ok",
          barrierDismissible: true
      );

      return;
    }



    Get.dialog(
        dialogContent(names,  playListSelected),
    );
  }


}
