class PointList {
  final List<Point> points;

  PointList({
    this.points,
  });

  factory PointList.fromJson(List<dynamic> parsedJson) {
    List<Point> points = new List<Point>();
    return new PointList(
      points: points,
    );
  }
}

class Point {
  String _thumb;
  String _code;
  String _title;
  String _activated_date;
  int _point;

  Point.fromJson(Map<String, dynamic> parsedJson) {
    _thumb = parsedJson['thumb'];
    _title = parsedJson['title'];
    _code = parsedJson['code'];
    _activated_date = parsedJson['activated_date'].toString();
    _point = parsedJson['point'];
  }

  String get thumb => _thumb;

  String get code => _code;

  String get title => _title;

  String get activated_date => _activated_date;

  int get point => _point;

  setPoint(int p) {
    _point = p;
  }
}
