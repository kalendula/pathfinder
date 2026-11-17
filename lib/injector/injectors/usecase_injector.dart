import 'package:pathfinder/injector/usecases/get_data_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:pathfinder/injector/usecases/send_data_usecase.dart';

class UsecaseInjector {
  static void register() {
    GetIt.I.registerLazySingleton<GetDataUsecase>(() => GetDataUsecase());
    GetIt.I.registerLazySingleton<SendDataUsecase>(() => SendDataUsecase());
  }
}
