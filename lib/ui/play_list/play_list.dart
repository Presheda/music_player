import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Color(0xffF2F7FD),
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {}),
          backgroundColor: Color(0xffF2F7FD),
          elevation: 0,
          title: Text("Playlist",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, color: Colors.black)),
        ),
        body:  Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10
          ),
          child: GridView.count(

                crossAxisCount: 2,
              children: List.generate(10, (index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    left: 5,
                    right: 5

                  ),
                  child: InkWell(
                    onTap: (){},
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/images/man_singing.jpg",
                                  ),
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.6),
                                  BlendMode.darken
                                )
                              )
                          ),
                        ),

                        Align(

                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[

                                Text("Rap Music",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                        fontWeight: FontWeight.w600, color: Color(0xffF2F7FD))
                                ),

                                SizedBox(
                                  height: 5,
                                ),

                                Text("17 Songs",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500, color: Color(0xffF2F7FD))
                                )
                              ],
                            ),
                          ),
                        )

                      ],
                    ),
                  )
                );
              }),

          ),
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),

    );
  }
}
