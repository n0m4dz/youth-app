import 'package:youth/core/models/video.dart';
import 'package:youth/core/services/video_service.dart';
import '../../locator.dart';
import 'base_model.dart';

class VideoModel extends BaseModel {
  VideoService api = locator<VideoService>();

  List<Video> get videoList => api.videoList;
  bool get hasData => api.hasData;

  Future getVideoList(page, {String action}) async {
    switch (action) {
      case 'refresh':
        await api.getVideoList(1, isForced: true);
        notifyListeners();
        break;
      case 'more':
        await api.getVideoList(page);
        notifyListeners();
        break;
      default:
        if (videoList.length == 0) {
          setLoading(true);
          await api.getVideoList(1);
          setLoading(false);
        }
        break;
    }
  }
}
