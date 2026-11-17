import 'package:pathfinder/network/models/data_model.dart';
import 'package:pathfinder/repositories/data_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:pathfinder/services/results_service.dart';

class SendDataUsecase {
  static final SendDataUsecase _singleton = SendDataUsecase._internal();
  final _dataRepository = GetIt.I.get<DataRepository>();
  Future<DataModel> execute(List<Result> results) {
    return _dataRepository.sendData(results);
  }

  factory SendDataUsecase() {
    return _singleton;
  }

  SendDataUsecase._internal();
}
