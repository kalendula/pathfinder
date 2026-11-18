import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:pathfinder/network/models/data_model.dart';
import 'package:pathfinder/network/models/response_model.dart';
import 'package:pathfinder/services/api_url_service.dart';
import 'package:pathfinder/services/results_service.dart';

abstract class ApiManager {
  Future<DataModel> sendData(List<Result> result);
  Future<DataModel> getData();
}

class ApiManagerImpl implements ApiManager {
  @override
  Future<DataModel> getData() async {
    String url = GetIt.I.get<ApiUrlService>().getUrl();
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        return DataModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        return DataModel(data: [], error: true, message: "Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      return DataModel(data: [], error: true, message: "Error while trying to map response from server");
    }
  }

  @override
  Future<DataModel> sendData(List<Result> result) async {
    final List<ResultItem> data = [];
    for (final res in result) {
      data.add(ResultItem.fromResult(res));
    }
    String url = GetIt.I.get<ApiUrlService>().getUrl();
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(data.map((e) => e.toJson()).toList()),
    );
    try {
      if (response.statusCode == 200) {
        return DataModel(data: [], error: false, message: "");
      } else {
        return DataModel(data: [], error: true, message: "Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      return DataModel(data: [], error: true, message: "Error while trying to map response from server");
    }
  }
}
