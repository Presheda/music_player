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
        );
      },
    );
  }
}
