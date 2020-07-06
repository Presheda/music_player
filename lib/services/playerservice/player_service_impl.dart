import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:music_player/services/hiveservice/hiveservice.dart';
import 'package:music_player/services/locator.dart';
import 'package:music_player/services/playerservice/player_service.dart';
import 'package:music_player/services/querysong/query_song_service.dart';

class PlayerServiceImpl implements PlayerService {
  var player = getIt<AudioPlayer>();
  var queryService = getIt<QuerySongService>();

  SongInfo songInfo;

  List<String> urls = [];

  var hiveService = getIt<HiveService>();
  int currentAudioIndex = 0;

  PlayerServiceImpl() {
    player.onCurrentAudioIndexChanged.listen((event) {

      print("AudioIndex 1");

      currentAudioIndex = event;
      saveLastPlayed();
    });

    player.onPlayerCompletion.listen((event) {
      print("One audio has just finished playing");
    });
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
  Future playPlaylist(String playListName) {

  }

  @override
  Future playAll() async {


    if (player.state == PlayerState.PLAYING) {
      await player.stop();
    }

    this.urls = queryService.url();
    await player.release();
    return player.playAll(urls);
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

  @override
  SongInfo getCurrentSong(){

    return this.songInfo;
  }

  void saveLastPlayed() async {


    print("Checking 1");


    SongInfo songInfo = queryService.songList()[currentAudioIndex];

    var box = await hiveService.openBox("lastPlayed");

    if (currentAudioIndex < 0 || urls.length <= 0) return;


    print("Checking 2");


    this.songInfo = songInfo;

    box.put("song", songInfo);


  }

}
