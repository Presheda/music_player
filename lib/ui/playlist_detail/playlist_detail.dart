import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'PlaylistDetailModel.dart';

class PlaylistDetail extends StatelessWidget {

  final name = Get.parameters["name"];



  @override
  Widget build(BuildContext context) {
    print(Get.parameters);
    print("name is: $name");
   return GetBuilder<PlaylistDetailModel>(
      init: PlaylistDetailModel(name: name),
      builder: (model){
         return Scaffold(
          appBar: AppBar(
            title: Text(name, style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500, ) ),
            backgroundColor: Color(0xffFECFB3),
          ),
             body: ListView.separated(
                 itemBuilder: (c, i) {
                   return ListTile(
                     onTap: () {
                       model.playSong(i);
                     },
                     leading: Container(
                       height: 50,
                       width: 50,
                       decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           image: DecorationImage(
                               fit: BoxFit.cover,
                               image:
                               AssetImage("assets/images/man_singing.jpg"))),
                     ),
                     title: Text(model.songList[i].title,
                         maxLines: 1,
                         style: GoogleFonts.poppins(
                             fontSize: 18,
                             fontWeight: FontWeight.w600,
                             color: Colors.black)),
                     subtitle: Text(model.songList[i].artist,
                         style: GoogleFonts.poppins(
                             fontSize: 16,
                             fontWeight: FontWeight.w500,
                             color: Color(0xff8C93A4))),
                     trailing: GetBuilder<PlaylistDetailModel>(
                       id: "updateIcons",
                       builder: (model) {
                         return showIcons(model, i, model.songList[i].filePath);
                       },
                     ),
                   );
                 },
                 separatorBuilder: (c, i) {
                   return Divider();
                 },
                 itemCount: model.songList.length));
      },
   );
  }

  showIcons(PlaylistDetailModel model, int position, String url) {
    bool isCurrentSong = model.currentUrl == model.songList[position].filePath;
    bool favorite = false; //model.isFavorite(url);

    if (isCurrentSong) {
      if (model.isPlaying) {
        return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.pause,
                color: Colors.blue,
                size: 30,
              ),
              onPressed: () {
                model.playPause();
              }),
          SizedBox(
            width: 15,
          ),
          favoriteIcon(model, favorite, url)
        ]);
      } else if (model.isPaused) {
        return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.play_arrow,
                color: Colors.blue,
                size: 30,
              ),
              onPressed: () {
                model.playPause();
              }),
          SizedBox(
            width: 15,
          ),
          favoriteIcon(model, favorite, url)
        ]);
      } else {
        return favoriteIcon(model, favorite, url);
      }
    } else {
      return favoriteIcon(model, favorite, url);
    }
  }

  favoriteIcon(PlaylistDetailModel model, bool favorite, String url) {
    String fav = favorite ? "Remove from favorite" : "Add to favorite";



    return PopupMenuButton<menuItems>(
      onSelected: (menuItems result) {
        if(result == menuItems.remove){
          model.removeFromPlayList(url);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<menuItems>>[
        PopupMenuItem<menuItems>(
          value: menuItems.remove,
          child: Text(fav),
        ),
      ],
    );
  }
}

enum menuItems { remove  }

