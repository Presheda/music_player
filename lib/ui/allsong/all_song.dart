import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllSongs extends StatelessWidget {
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
          title: Text("All Songs",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, color: Colors.black)),
        ),
        body: ListView.separated(
            itemBuilder: (c, i) {
              return ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/man_singing.jpg"))),
                ),
                title: Text("Better Together ",
                    maxLines: 1,
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                subtitle: Text("Kanye West",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff8C93A4))),
                trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: true
                        ? <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.favorite_border,
                                ),
                                onPressed: () {}),
                            SizedBox(
                              width: 15,
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.pause,
                                ),
                                onPressed: () {}),
                          ]
                        : <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.favorite_border,
                                ),
                                onPressed: () {}),
                            SizedBox(
                              width: 15,
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.pause,
                                ),
                                onPressed: () {}),
                          ]),
              );
            },
            separatorBuilder: (c, i) {
              return Divider();
            },
            itemCount: 15));
  }
}
