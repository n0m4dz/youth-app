class SlideList {
  final List<Slide> Slides;

  SlideList({
    this.Slides,
  });

  factory SlideList.fromJson(List<dynamic> parsedJson) {
    List<Slide> Slides = new List<Slide>();
    return new SlideList(
      Slides: Slides,
    );
  }
}

class Slide {
  int _id;
  String _image;
  String _title;
  String _link;

  Slide.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id'];
    _image = parsedJson['image'];
    _title = parsedJson['title'];
    _link = parsedJson['link'];
  }

  int get id => _id;

  String get image => _image;

  String get title => _title;

  String get link => _link;
}
