import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:google_fonts/google_fonts.dart';

class NowPlaying extends StatelessWidget {
  //backgroundColor:  Color(0xffF2F7FD),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F7FD),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {}),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onPressed: () {}),
        ],
        backgroundColor: Color(0xffF2F7FD),
        elevation: 0,
        title: Text("Playing Now",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, color: Colors.black)),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: MediaQuery.of(context).size.width * 0.65,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/man_singing.jpg"))),
                ),
                SizedBox(
                  height: 30,
                ),
                Text("Better Together",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                SizedBox(
                  height: 10,
                ),
                Text("Kanye West",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff8C93A4))),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffF2F7FD),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white,
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(5, -5))
                      ]),
                  height: 20,
                  child: FlutterSlider(
                    values: [50],
                    max: 100,
                    min: 0,
                    handler: FlutterSliderHandler(
                      decoration: BoxDecoration(),
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffFECFB3)),
                      ),
                    ),
                    trackBar: FlutterSliderTrackBar(
                      inactiveTrackBar: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffF2F7FD),
                      ),
                      activeTrackBarHeight: 7,
                      inactiveTrackBarHeight: 5,
                      activeTrackBar: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0xffFECFB3)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Ionicons.md_skip_backward,
                            color: Color(0xffD6E0EA),
                          ),
                          onPressed: () {}),
                      Material(
                        color: Color(0xffF2F7FD),
                        borderOnForeground: false,
                        shape: CircleBorder(

                        ),
                        elevation: 10.0,
                        child: Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffFECFB3)
                          ),
                          child: Center(
                            child: IconButton(
                                icon: Icon(Ionicons.md_play,
                                  size: 30,
                                  color: Colors.white,
                                ), onPressed: () {}),
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Ionicons.md_skip_forward,
                            color: Color(0xffD6E0EA),
                          ),
                          onPressed: () {}),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
