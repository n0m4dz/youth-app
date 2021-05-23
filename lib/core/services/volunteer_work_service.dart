import 'package:youth/core/models/volunteer_work.dart';

import '../../locator.dart';
import 'api.dart';

class VolunteerWorkService {
  Api api = locator<Api>();

  int _page = 1;
  int get page => _page;
  bool _hasData = true;
  bool get hasData => _hasData;

  List<VolunteerWork> _volunteerWorks = new List();
  List<VolunteerWork> get volunteerWorkList => _volunteerWorks;

  Future<void> getVolunteerServiceWorkList(page,
      {bool isForced = false}) async {
    if (isForced) {
      _volunteerWorks = new List();
      _hasData = true;
    }
    _page = page;

    if (_hasData) {
      if (page == 1 && _volunteerWorks.length > 0) {
        return;
      }
      List<VolunteerWork> data = await api.getVolunteerWorks(page);
      if (data.length == 0) {
        _hasData = false;
      } else {
        _volunteerWorks = _volunteerWorks + data;
      }
    }
  }
}
