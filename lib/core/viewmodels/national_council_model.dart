import 'package:youth/core/models/national_council.dart';
import 'base_model.dart';
import '../../locator.dart';
import 'package:youth/core/services/national_council_service.dart';

class NationalCouncilModel extends BaseModel {
  NationalCouncilService api = locator<NationalCouncilService>();

  List<NationalCouncil> get nationalCouncilList => api.councilList;

  Future<void> getNationalList({String search, action}) async {
    print(action);
    if (action == 'searching') {
      setLoading(true);
      await api.getCouncils(search, isForced: true);
      notifyListeners();
      setLoading(false);
    } else {
      setLoading(true);
      await api.getCouncils(search);
      setLoading(false);
    }
  }
}
