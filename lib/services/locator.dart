
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:get_it/get_it.dart';
import 'package:music_player/services/playerservice/player_service_impl.dart';
import 'package:music_player/services/querysong/query_song_impl.dart';
import 'package:music_player/services/querysong/query_song_service.dart';

import 'playerservice/player_service.dart';

GetIt getIt = GetIt.instance;


 void setupServices(){
   getIt.registerLazySingleton(() => AudioPlayer());
   getIt.registerFactory(() => FlutterAudioQuery());
   getIt.registerLazySingleton<PlayerService>(() => PlayerServiceImpl());
   getIt.registerLazySingleton<QuerySongService>(() => QuerySongServiceImpl());

 }