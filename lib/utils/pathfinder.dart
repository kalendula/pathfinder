import 'package:pathfinder/network/models/data_model.dart';

class PathFinder {
  final List<List<int>> field;
  List<List<int>> fieldVisit = [];
  final Point start;
  final Point end;

  PathFinder({required this.field, required this.start, required this.end});

  List<Point> findPath() {
    if (!checkPoint(start) || !checkPoint(end)) return [];
    fieldVisit = List.from(field);
    for (int i = 0; i < field.length; i++) {
      for (int j = 0; j < field[i].length; j++) {
        if (field[i][j] == 0)
          fieldVisit[i][j] = 1;
        else
          fieldVisit[i][j] = 0;
      }
    }
    final res = <Point>[];
    res.add(start);
    fieldVisit[start.y][start.x] = 1;
    if (start == end) return res;
    while (res.last != end) {
      final point = _makeStep(res.last);
      if (point == null) return [];
      fieldVisit[point.y][point.x] = 1;
      res.add(point);
    }
    return res;
  }

  Point? _makeStep(Point from) {
    List<Point> allPossiblePoints = [
      Point(x: from.x - 1, y: from.y - 1),
      Point(x: from.x, y: from.y - 1),
      Point(x: from.x + 1, y: from.y - 1),
      Point(x: from.x - 1, y: from.y),
      Point(x: from.x + 1, y: from.y),
      Point(x: from.x - 1, y: from.y + 1),
      Point(x: from.x, y: from.y + 1),
      Point(x: from.x + 1, y: from.y + 1),
    ];
    List<Point> legalPoints = [];
    for (Point point in allPossiblePoints) {
      if (checkPoint(point) && coordExists(fieldVisit, point.x, point.y) && fieldVisit[point.y][point.x] == 0) {
        legalPoints.add(point);
      }
    }
    if (legalPoints.isEmpty) return null;
    if (legalPoints.length == 1) return legalPoints.first;
    Point resPoint = legalPoints.first;
    for (int i = 1; i < legalPoints.length; i++) {
      final pxOffset = (resPoint.x - end.x).abs();
      final pyOffset = (resPoint.y - end.y).abs();
      final poffset = pxOffset + pyOffset;
      final xOffset = (legalPoints[i].x - end.x).abs();
      final yOffset = (legalPoints[i].y - end.y).abs();
      final offset = xOffset + yOffset;
      if (offset < poffset) resPoint = legalPoints[i];
    }
    return resPoint;
  }

  bool checkPoint(Point a) {
    if (a.y < 0 || a.y > field.length - 1) return false;
    if (a.x < 0 || a.x > field[a.y].length - 1) return false;
    return true;
  }
}

bool coordExists(List<List<int>> field, int x, int y) {
  return y >= 0 && y < field.length && x >= 0 && x < field[y].length;
}
