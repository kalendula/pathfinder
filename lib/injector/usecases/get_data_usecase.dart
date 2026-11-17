import 'package:pathfinder/network/models/data_model.dart';
import 'package:pathfinder/repositories/data_repository.dart';
import 'package:get_it/get_it.dart';

class GetDataUsecase {
  static final GetDataUsecase _singleton = GetDataUsecase._internal();
  final _dataRepository = GetIt.I.get<DataRepository>();
  Future<DataModel> execute() {
    return _dataRepository.getData();
  }

  factory GetDataUsecase() {
    return _singleton;
  }

  GetDataUsecase._internal();
}
