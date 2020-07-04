import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:get/get.dart';
import 'package:music_player/services/locator.dart';
import 'package:music_player/ui/homepage/now_playing.dart';
import 'package:music_player/ui/shared/main_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  setupServices();

  await FlutterStatusbarcolor.setStatusBarColor(Color(0xffFECFB3));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zero Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

