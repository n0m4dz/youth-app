import 'package:youth/core/models/national_council.dart';
import 'base_model.dart';
import '../../locator.dart';
import 'package:youth/core/services/national_council_service.dart';

class NationalCouncilModel extends BaseModel {
  NationalCouncilService api = locator<NationalCouncilService>();

  bool get hasData => api.hasData;
  int get aimagId => api.aimagId;
  int get soumId => api.soumId;

  List<NationalCouncil> get nationalCouncilList => api.councilList;

  Future<void> getNationalList(int aimagId, int soumId, {String action}) async {
    switch (action) {
      case 'selected':
        setLoading(true);
        await api.getCouncils(aimagId, soumId, isForced: true);
        notifyListeners();
        setLoading(false);
        break;
      default:
        setLoading(true);
        await api.getCouncils(aimagId, soumId);

        setLoading(false);
        break;
    }
    // setLoading(true);
    // await api.getCouncils();
    // setLoading(false);
  }

  searchTrack(val) {
    api.searchTrack(val);
    notifyListeners();
  }
}
