import 'dart:convert';

import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:music_player/model/HiveSongInfo.dart';
import 'package:music_player/services/hiveservice/hiveservice.dart';
import 'package:music_player/services/locator.dart';
import 'package:music_player/services/playerservice/player_service.dart';
import 'package:music_player/services/querysong/query_song_service.dart';

class PlayerServiceImpl implements PlayerService {
  var player = getIt<AudioPlayer>();
  var queryService = getIt<QuerySongService>();

  HiveSongInfo songInfo;

  List<String> urls = [];

  var hiveService = getIt<HiveService>();
  int currentAudioIndex = 0;

  bool playListFavorite = false;


  String currentPlayList = "";


  PlayerServiceImpl() {
    loadPreviousSong();

    player.onCurrentAudioIndexChanged.listen((event) {
      currentAudioIndex = event;
      saveLastPlayed();
    });



    player.onPlayerCompletion.listen((event) {
      print("One audio has just finished playing");
    });
  }

  Future<void> loadPreviousSong() async {
    var box = await hiveService.openBox("lastPlayed");

    var songInfo = box.get("song");

    this.songInfo = songInfo;


  }

  @override
  Future<HiveSongInfo> getCurrentSong() async {
    if (this.songInfo == null) {
      await loadPreviousSong();
    }
    return this.songInfo;
  }

  @override
  String getCurrentPlaylist()  {

    return currentPlayList;
  }

  @override
  PlayerState getPlayerState(){

    return player.playerState;
  }

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
  Future playPlaylistFavorites(List<String> url, int index, {String name}) async {

    if (player.state == PlayerState.PLAYING) {
      await player.stop();
    }

    if(name != null){
      this.currentPlayList = name;
    }

    this.urls = url;
    await player.release();
    this.playListFavorite = true;
    return player.playAll(urls, index: index);
  }

  @override
  Future playAll({int index, int position}) async {
    if (player.state == PlayerState.PLAYING) {
      await player.stop();
    }

    this.currentPlayList = "";

    this.urls = queryService.url();
    await player.release();
    this.playListFavorite = false;
    return player.playAll(urls, index: index);
  }

  @override
  Future previous() {
    return player.previous();
  }

  @override
  Future resumeSong() {
    return player.resume();
  }

  @override
  Future seek(double position) {
    Duration duration = Duration(seconds: position.floor());

    return player.seekPosition(duration);
  }

  @override
  Stream<Duration> duration() {
    return player.onDurationChanged;
  }

  @override
  Stream<Duration> audioPosition() {
    return player.onAudioPositionChanged;
  }

  @override
  Stream<PlayerState> playerState() {
    return player.onPlayerStateChanged;
  }

  @override
  Future<Duration> getCurrentDuration() {
    return player.getDuration();
  }

  @override
  Stream<int> audioIndex() {
    return player.onCurrentAudioIndexChanged;
  }



  void saveLastPlayed() async {
    if (currentAudioIndex < 0 || urls.length <= 0) return;
    SongInfo songInfo;

    if(playListFavorite){
      songInfo = queryService.playListFavorites()[currentAudioIndex];
    } else{
      songInfo = queryService.songList()[currentAudioIndex];
    }

    HiveSongInfo hiveSongInfo = HiveSongInfo();
    hiveSongInfo.mapSong(songInfo);
    hiveSongInfo.index = currentAudioIndex;
    this.songInfo = hiveSongInfo;
    var box = await hiveService.openBox("lastPlayed");

    box.put("song", hiveSongInfo);
  }
}
