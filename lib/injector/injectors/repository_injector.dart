import 'package:pathfinder/repositories/data_repository.dart';
import 'package:get_it/get_it.dart';

class RepositoryInjector {
  static void register() {
    GetIt.I.registerLazySingleton<DataRepository>(() => DataRepositoryImpl());
  }
}
