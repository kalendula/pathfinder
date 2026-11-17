import 'package:get_it/get_it.dart';
import 'package:pathfinder/injector/usecases/get_data_usecase.dart';
import 'package:pathfinder/network/models/data_model.dart';
import 'package:pathfinder/services/api_url_service.dart';
import 'package:pathfinder/services/results_service.dart';
import 'package:pathfinder/utils/pathfinder.dart';
import 'package:rxdart/rxdart.dart';

final URLRegexp =
    RegExp(r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_+~#?&//=]*)');

class HomeScreenBloc {
  bool inProgress = false;
  DataModel? data = null;
  final _screenStateSubject = BehaviorSubject<ScreenState>();

  Stream<ScreenState> get screenStateStream => _screenStateSubject.stream;

  HomeScreenBloc() {
    resetScreen();
  }

  void resetScreen() {
    data = null;
    String url = GetIt.I.get<ApiUrlService>().getUrl();
    _screenStateSubject.add(ScreenState.start(url));
  }

  void startCounting(String url) async {
    if (inProgress) return;
    inProgress = true;
    if (URLRegexp.hasMatch(url)) {
      GetIt.I.get<ApiUrlService>().setUrl(url);
      final res = await GetIt.I.get<GetDataUsecase>().execute();
      if (res.error) {
        _screenStateSubject.add(ScreenState.error(res.message));
        inProgress = false;
        return;
      }
      data = res;
      _screenStateSubject.add(ScreenState.counting(0));
      _counting();
    } else {
      _screenStateSubject.add(ScreenState.error('URL is not valid'));
    }
    inProgress = false;
  }

  void sendResult() {
    if (inProgress) return;
    inProgress = true;
    if (data == null) {
      _screenStateSubject.add(ScreenState.error('Something went wrong'));
      return;
    }
    final results = GetIt.I.get<ResultService>().getResults();
    final request = <Result>[];
    for (final res in data!.data) {
      try {
        request.add(results.firstWhere((e) => e.id == res.id));
      } catch (e) {
        request.add(Result(end: res.end, start: res.start, id: res.id, field: [], path: []));
      }
    }
    inProgress = false;
    resetScreen();
  }

  void _counting() {
    if (data == null) {
      _screenStateSubject.add(ScreenState.error('Something went wrong'));
      return;
    }
    final safeData = data!;
    final length = safeData.data.length;
    final percent = 100 / length;
    double progress = 0;
    for (final req in safeData.data) {
      List<List<int>> field = [];
      for (final row in req.field) {
        final parsedRow = row.split(' ');
        final convRow = <int>[];
        for (final char in parsedRow) {
          if (char == '.') convRow.add(1);
          if (char == 'X') convRow.add(0);
        }
        field.add(convRow);
      }
      final res = PathFinder(field: field.deepCopy(), start: req.start, end: req.end).findPath();
      GetIt.I
          .get<ResultService>()
          .addResult(Result(id: req.id, field: field, start: req.start, end: req.end, path: res));
      progress += percent;
      _updateProgress(progress);
      _screenStateSubject.add(ScreenState.success());
    }
  }

  void _updateProgress(double progress) {
    _screenStateSubject.add(ScreenState.counting(progress));
  }

  void dispose() {
    _screenStateSubject.close();
  }
}

enum ScreenStateEnum { start, counting, success, error }

class ScreenState {
  final ScreenStateEnum type;
  final String error;
  final double progress;
  final String url;
  ScreenState({required this.type, required this.error, required this.progress, required this.url});

  factory ScreenState.error(String error) =>
      ScreenState(error: error, type: ScreenStateEnum.error, progress: 0, url: '');
  factory ScreenState.counting(double progress) =>
      ScreenState(error: '', type: ScreenStateEnum.counting, progress: progress, url: '');
  factory ScreenState.start(String url) => ScreenState(error: '', type: ScreenStateEnum.start, progress: 0, url: url);
  factory ScreenState.success() => ScreenState(error: '', type: ScreenStateEnum.success, progress: 100, url: '');
}

extension DeepCopy on List<List<int>> {
  List<List<int>> deepCopy() => [
        for (final row in this) [...row]
      ];
}
