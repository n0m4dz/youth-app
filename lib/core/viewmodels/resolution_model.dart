import 'package:youth/core/models/resolution.dart';
import 'package:youth/core/services/resolution_service.dart';

import 'base_model.dart';
import '../../locator.dart';

class ResolutionModel extends BaseModel {
  ResolutionService api = locator<ResolutionService>();

  bool get hasData => api.hasData;
  int get page => api.page;

  List<Resolution> get resolutionList => api.resolutionList;

  Future<void> getResolutionList(int aimagId, int page, {String action}) async {
    switch (action) {
      case 'refresh':
        await api.getResolution(aimagId, 1, isForced: true);
        notifyListeners();
        break;
      case 'more':
        await api.getResolution(aimagId, page);
        notifyListeners();
        break;
      default:
        if (resolutionList.length == 0) {
          setLoading(true);
          await api.getResolution(aimagId, 1);
          setLoading(false);
        }
        break;
    }
  }
}
