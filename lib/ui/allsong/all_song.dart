import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/ui/allsong/AllSongViewModel.dart';

class AllSongs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("MainWid rebuilt");
    return GetBuilder<AllSongViewModel>(
      init: AllSongViewModel(),
      builder: (model) {
        print("SecondWid rebuilt");
        return Scaffold(
            backgroundColor: Color(0xffF2F7FD),
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {}),
              backgroundColor: Color(0xffF2F7FD),
              elevation: 0,
              title: Text("All Songs",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, color: Colors.black)),
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
                    trailing: GetBuilder<AllSongViewModel>(
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

  showIcons(AllSongViewModel model, int position, String url) {

    bool isCurrentSong = model.currentUrl == model.songList[position].filePath;
    bool favorite = model.isFavorite(url);

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

  favoriteIcon(AllSongViewModel model, bool favorite, String url) {
    if (favorite) {
      return IconButton(
          icon: Icon(Icons.favorite, color: Colors.red),
          onPressed: () {
            model.saveFavoriteSong(url);
          });
    } else {
      return IconButton(
          icon: Icon(
            Icons.favorite_border,
          ),
          onPressed: () {
            model.saveFavoriteSong(url);
          });
    }
  }
}
