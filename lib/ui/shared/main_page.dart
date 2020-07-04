import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/ui/allsong/all_song.dart';
import 'package:music_player/ui/favorite_song/favorite_song.dart';
import 'package:music_player/ui/homepage/now_playing.dart';
import 'package:music_player/ui/play_list/play_list.dart';
import 'package:music_player/viewmodel/MainPageViewModel.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainPageViewModel>(
        init: MainPageViewModel(),
        builder: (controller) {
          print("A rebuilt");
          return Scaffold(
            body: SizedBox.expand(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                onPageChanged: (index) {
                },
                children: <Widget>[
                  NowPlaying(),
                  AllSongs(),
                  FavoriteSongs(),
                  PlayList()
                ],
              ),
            ),
            bottomNavigationBar: GetBuilder<MainPageViewModel>(
              id: "bottomNav",
              builder: (con){
                return BottomNavyBar(
                  selectedIndex: controller.currentIndex,
                  onItemSelected: (index) {
                    controller.updatePage(index);
                  },
                  items: <BottomNavyBarItem>[
                    _bottomNavItem("Playing", Icon(Icons.play_circle_outline)),
                    _bottomNavItem("All songs", Icon(Icons.library_music)),
                    _bottomNavItem("Favorite", Icon(Icons.favorite)),
                    _bottomNavItem("Playlist", Icon(Icons.playlist_add)),
                  ],
                );
              },
            )
          );
        });
  }

  _bottomNavItem(String title, Icon icon) {
    return BottomNavyBarItem(
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        inactiveColor: Color(0xffFECFB3),
        activeColor: Colors.blue,
        icon: icon);
  }
}
