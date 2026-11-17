class DataModel {
  final bool error;
  final String message;
  final List<Field> data;

  DataModel({
    required this.error,
    required this.message,
    required this.data,
  });

  DataModel copyWith({
    bool? error,
    String? message,
    List<Field>? data,
  }) =>
      DataModel(
        error: error ?? this.error,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        error: json['error'] as bool,
        message: json['message'] as String,
        data: (json['data'] as List<dynamic>).map((e) => Field.fromJson(e as Map<String, dynamic>)).toList(),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'data': data.map((e) => e.toJson()).toList(),
      };
}

class Field {
  final String id;
  final List<String> field;
  final Point start;
  final Point end;

  Field({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  Field copyWith({
    String? id,
    List<String>? field,
    Point? start,
    Point? end,
  }) =>
      Field(
        id: id ?? this.id,
        field: field ?? this.field,
        start: start ?? this.start,
        end: end ?? this.end,
      );

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        id: json['id'] as String,
        field: (json['field'] as List<dynamic>).map((e) => e as String).toList(),
        start: Point.fromJson(json['start'] as Map<String, dynamic>),
        end: Point.fromJson(json['end'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'field': field,
        'start': start.toJson(),
        'end': end.toJson(),
      };
}

class Point {
  final int x;
  final int y;

  Point({
    required this.x,
    required this.y,
  });

  @override
  bool operator ==(Object other) {
    return (other is Point) && other.x == x && other.y == y;
  }

  @override
  String toString() {
    return 'POINT: (x:$x, y:$y)';
  }

  @override
  int get hashCode => super.hashCode;

  Point copyWith({
    int? x,
    int? y,
  }) =>
      Point(
        x: x ?? this.x,
        y: y ?? this.y,
      );

  factory Point.fromJson(Map<String, dynamic> json) => Point(
        x: json['x'] as int,
        y: json['y'] as int,
      );

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
      };
}
