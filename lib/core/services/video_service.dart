import 'package:youth/core/models/video.dart';

import '../../locator.dart';
import 'api.dart';

class VideoService {
  Api api = locator<Api>();

  List<Video> _videos = new List();
  List<Video> get videoList => _videos;

  bool _hasData = true;
  bool get hasData => _hasData;

  Future<void> getVideoList(page, {bool isForced = false}) async {
    if (isForced) {
      _videos = new List();
      _hasData = true;
    }

    if (_hasData) {
      List<Video> data = await api.getVideoList(page);
      if (data.length == 0) {
        _hasData = false;
      } else {
        _videos += data;
      }
    }
  }
}
