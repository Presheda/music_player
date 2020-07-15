import 'package:get/get.dart';
import 'package:music_player/model/playlist_model.dart';
import 'package:music_player/services/hiveservice/hiveservice.dart';
import 'package:music_player/services/locator.dart';
import 'package:music_player/ui/play_list/play_list_dialog.dart';
import 'package:stacked_services/stacked_services.dart';

class PlayListModel extends GetxController {
  var hiveService = getIt<HiveService>();
  var dialogService = getIt<DialogService>();

  List<HivePlaylistModel> _playListName = [];

  List<HivePlaylistModel> get playListName => _playListName;

  PlayListModel() {
    fetchPlaylist();
  }

  void fetchPlaylist() async {
    var playListBox = await hiveService.openBox("playList");
    List<String> names = playListBox.get("playListNames");

    if(names == null){
      return;
    }

    names.forEach((element) {
      HivePlaylistModel model = playListBox.get(element);
      _playListName.add(model);
    });
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
}
