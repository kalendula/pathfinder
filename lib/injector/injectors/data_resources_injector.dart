import 'package:pathfinder/network/api_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:pathfinder/services/api_url_service.dart';
import 'package:pathfinder/services/results_service.dart';

class DataResourcesInjector {
  static void register() {
    GetIt.I.registerLazySingleton<ApiManager>(() => ApiManagerImpl());
    GetIt.I.registerLazySingleton<ApiUrlService>(() => ApiUrlService());
    GetIt.I.registerLazySingleton<ResultService>(() => ResultService());
  }
}
