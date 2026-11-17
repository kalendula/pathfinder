import 'package:pathfinder/network/models/data_model.dart';

class ResultService {
  List<Result> _results = [];

  static final ResultService _singleton = ResultService._internal();

  void addResult(Result result) {
    _results.add(result);
  }

  List<Result> getResults() {
    return List.from(_results);
  }

  factory ResultService() {
    return _singleton;
  }

  ResultService._internal();
}

class Result {
  final String id;
  final List<List<int>> field;
  final Point start;
  final Point end;
  final List<Point> path;

  String get stringPath {
    String pathString = '';
    for (int i = 0; i < path.length; i++) {
      if (i == path.length - 1) {
        pathString += '(${path[i].x},${path[i].y})';
      } else {
        pathString += '(${path[i].x},${path[i].y})->';
      }
    }
    return pathString;
  }

  Result({required this.id, required this.field, required this.start, required this.end, required this.path});
}
