
import 'package:flutter_exoplayer/audioplayer.dart';

abstract class PlayerService{


  Future<dynamic> playSong(String url);

  Future<dynamic> playAll(List<String> url);

  Future<dynamic> pauseSong();

  Future<dynamic> resumeSong();

  Future<dynamic> previous();

  Future<dynamic> next();

  Future<dynamic> seek();

  Stream<Duration> duration();

  void audioPosition();

  void playerState();


}