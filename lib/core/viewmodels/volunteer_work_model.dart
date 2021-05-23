// import 'package:youth/core/models/aimag_news.dart';
// import 'package:youth/core/services/aimag_news_service.dart';
// import 'package:youth/core/viewmodels/base_model.dart';
// import 'package:youth/locator.dart';

// class AimagNewsModel extends BaseModel {
//   AimagNewsService _api = locator<AimagNewsService>();

//   bool get hasData => _api.hasData;
//   int get page => _api.page;

//   List<AimagNews> get aimagNewsList => _api.aimagNewsList;

//   Future<void> getAimagNewsModelList(int aimagId, int page,
//       {String action}) async {
//     switch (action) {
//       case 'refresh':
//         setLoading(true);
//         await _api.getAimagNewsList(aimagId, 1, isForced: true);
//         notifyListeners();
//         setLoading(false);
//         break;
//       case 'more':
//         await _api.getAimagNewsList(aimagId, page);
//         notifyListeners();
//         break;
//       default:
//         setLoading(true);
//         await _api.getAimagNewsList(aimagId, 1);
//         setLoading(false);

//         break;
//     }
//   }
// }

import 'package:youth/core/models/volunteer_work.dart';
import 'package:youth/core/services/volunteer_work_service.dart';
import 'package:youth/core/viewmodels/base_model.dart';

import '../../locator.dart';

class VolunteerWorkModel extends BaseModel {
  VolunteerWorkService _api = locator<VolunteerWorkService>();

  bool get hasData => _api.hasData;
  int get page => _api.page;

  List<VolunteerWork> get volunteerWorkList => _api.volunteerWorkList;

  Future<void> getVolunteerModelWorkList(int page, {String action}) async {
    switch (action) {
      case 'refresh':
        setLoading(true);
        await _api.getVolunteerServiceWorkList(page, isForced: true);
        notifyListeners();
        setLoading(false);
        break;
      case 'more':
        await _api.getVolunteerServiceWorkList(page);
        notifyListeners();
        break;
      default:
        setLoading(true);
        await _api.getVolunteerServiceWorkList(1);
        setLoading(false);

        break;
    }
  }
}
