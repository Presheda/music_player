
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:get_it/get_it.dart';
import 'package:music_player/services/hiveservice/hive_service_impl.dart';
import 'package:music_player/services/hiveservice/hiveservice.dart';
import 'package:music_player/services/playerservice/player_service_impl.dart';
import 'package:music_player/services/querysong/query_song_impl.dart';
import 'package:music_player/services/querysong/query_song_service.dart';
import 'package:stacked_services/stacked_services.dart';

import 'playerservice/player_service.dart';

GetIt getIt = GetIt.instance;


 void setupServices(){
   getIt.registerLazySingleton(() => AudioPlayer());
   getIt.registerFactory(() => FlutterAudioQuery());
   getIt.registerFactory<HiveService>(() => HiveServiceImpl());
   getIt.registerLazySingleton<PlayerService>(() => PlayerServiceImpl());
   getIt.registerLazySingleton(() => DialogService());
   getIt.registerLazySingleton(() => SnackbarService());
   getIt.registerLazySingleton<QuerySongService>(() => QuerySongServiceImpl());

 }