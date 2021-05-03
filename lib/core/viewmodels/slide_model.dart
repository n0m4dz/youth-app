import 'package:youth/core/services/home_service.dart';
import 'package:youth/core/models/slide.dart';
import '../../locator.dart';
import 'base_model.dart';

class SlidesModel extends BaseModel {
  HomeService api = locator<HomeService>();
  List<Slide> get slides => api.slideList;

  Future getSlides() async {
    setLoading(true);
    await api.getSlides();
    setLoading(false);
  }
}
