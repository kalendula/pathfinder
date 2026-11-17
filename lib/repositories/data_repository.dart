import 'package:pathfinder/network/api_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:pathfinder/network/models/data_model.dart';
import 'package:pathfinder/services/results_service.dart';

abstract class DataRepository {
  Future<DataModel> getData();
  Future<DataModel> sendData(List<Result> results);
}

class DataRepositoryImpl implements DataRepository {
  final _apiManager = GetIt.I.get<ApiManager>();
  @override
  Future<DataModel> getData() async {
    return await _apiManager.getData();
  }

  @override
  Future<DataModel> sendData(List<Result> results) async {
    return await _apiManager.sendData(results);
  }
}
