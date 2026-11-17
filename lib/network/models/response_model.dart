import 'package:pathfinder/network/models/data_model.dart';
import 'package:pathfinder/services/results_service.dart';

class ResultData {
  final List<Point> steps;
  final String path;

  ResultData({required this.steps, required this.path});

  Map<String, dynamic> toJson() => {
        'steps': steps.map((e) => e.toJson()).toList(),
        'path': path,
      };
}

class ResultItem {
  final String id;
  final ResultData result;

  ResultItem({required this.id, required this.result});

  Map<String, dynamic> toJson() => {
        'id': id,
        'result': result.toJson(),
      };

  factory ResultItem.fromResult(Result resultData) {
    return ResultItem(
      id: resultData.id,
      result: ResultData(
        steps: resultData.path,
        path: resultData.stringPath,
      ),
    );
  }
}
