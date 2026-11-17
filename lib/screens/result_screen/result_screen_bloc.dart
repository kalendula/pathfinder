import 'package:get_it/get_it.dart';
import 'package:pathfinder/services/results_service.dart';
import 'package:rxdart/rxdart.dart';

class ResultScreenBloc {
  final _resultsSubject = BehaviorSubject<List<Result>>();

  Stream<List<Result>> get resultsStream => _resultsSubject.stream;

  ResultScreenBloc() {
    _resultsSubject.add(GetIt.I.get<ResultService>().getResults());
  }

  void dispose() {
    _resultsSubject.close();
  }
}
