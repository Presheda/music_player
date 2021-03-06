import 'dart:async';

import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:get/get.dart';
import 'package:music_player/model/playlist_model.dart';
import 'package:music_player/services/hiveservice/hiveservice.dart';
import 'package:music_player/services/locator.dart';
import 'package:music_player/services/playerservice/player_service.dart';
import 'package:music_player/services/querysong/query_song_service.dart';
import 'package:music_player/ui/play_list/play_list_dialog.dart';
import 'file:///C:/Users/Precious/FlutterApp/music_player/lib/ui/playlist_detail/playlist_detail.dart';
import 'package:stacked_services/stacked_services.dart';

class PlayListModel extends GetxController {
  var hiveService = getIt<HiveService>();
  var dialogService = getIt<DialogService>();
  var playerService = getIt<PlayerService>();
  var queryService = getIt<QuerySongService>();

  List<HivePlaylistModel> _playListName = [];
  List<SongInfo> songList = [];


  StreamSubscription<PlayerState> state;

  bool isPaused = false;
  bool isPlaying = false;



  List<HivePlaylistModel> get playListName => _playListName;


  String  get currentPlaylist => playerService.getCurrentPlaylist();


  PlayListModel() {

    playerStateChanged(playerService.getPlayerState());
    addSubSubscription();
    fetchPlaylist();
  }

  void fetchPlaylist() async {
    var playListBox = await hiveService.openBox("playList");
    List<String> names = playListBox.get("playListNames");

    if(names == null){
      return;
    }

    _playListName.clear();
    names.forEach((element) {
      HivePlaylistModel model = playListBox.get(element);
      _playListName.add(model);
    });
    update();
  }

  void playPlaylist(HivePlaylistModel model) async {


    if(model.urls == null || model.urls.isEmpty){
      return;
    }

    if(currentPlaylist == model.name){
      if (isPlaying) {
        playerService.pauseSong();
        update();
        return;
      }

      if (isPaused) {
        playerService.resumeSong();
        update();
        return;
      }
    }



    FlutterAudioQuery query = FlutterAudioQuery();

    songList = await query.getSongs()
      ..retainWhere((element) => model.urls.contains(element.filePath));
    queryService.addPlayListFavorite(songList);

    playerService.playPlaylistFavorites(model.urls, 0, name : model.name);
    update();

  }

  void addPlayList() async {
    registerCustomDialogUi();

    var dialog = await dialogService.showCustomDialog();

    if (!dialog.confirmed) {
      return;
    }

    String playListName = dialog.responseData[0];

    var playListBox = await hiveService.openBox("playList");

    List<String> names = playListBox.get("playListNames");

    if(names == null){
      names = [];
    }

    names.add(playListName);

    HivePlaylistModel model = HivePlaylistModel();
    model.name = playListName;




    playListBox.put(playListName, model);
    playListBox.put("playListNames", names);

    fetchPlaylist();
  }

  void deletePlaylist(String plname) async {



   var dialog = await dialogService.showDialog(
     title: "Delete ?",
     description: "please confirm action",
     buttonTitle: "Delete",
     cancelTitle: "Cancel"

    );

   if(!dialog.confirmed){
     return;
   }



    var playListBox = await hiveService.openBox("playList");

    List<String> names = playListBox.get("playListNames");

    if(names == null){
      names = [];
    }

    names.remove(plname);



    playListBox.delete(plname);
    playListBox.put("playListNames", names);

    fetchPlaylist();
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

  }

  void openDetail(String name) {

    String route = "/playlist/$name";

    print("rout is: $route");
    Get.toNamed(route, );
  }



}
