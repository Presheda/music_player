
import 'package:get_it/get_it.dart';
import 'package:music_player/services/playerservice/player_service_impl.dart';
import 'package:music_player/services/querysong/query_song_impl.dart';

GetIt getIt = GetIt.instance();


 void setupServices(){
   getIt.registerLazySingleton(() => PlayerServiceImpl());
   getIt.registerLazySingleton(() => QuerySongServiceImpl());

 }