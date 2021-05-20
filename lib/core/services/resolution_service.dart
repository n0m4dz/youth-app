// import 'package:youth/core/models/aimag.dart';
// import '../../locator.dart';
// import 'api.dart';

// class AimagService {
//   Api api = locator<Api>();

//   List<Aimag> _aimaguud = new List();
//   List<Aimag> get aimagList => _aimaguud;

//   getAimags() async {
//     _aimaguud = await api.getAimagList();
//   }
// }

import 'package:youth/core/models/resolution.dart';
import 'package:youth/locator.dart';

import 'api.dart';

class ResolutionService {
  Api api = locator<Api>();

  int _page = 1;
  int get page => _page;
  bool _hasData = true;
  bool get hasData => _hasData;

  List<Resolution> _resolutions = new List();
  List<Resolution> get resolutionList => _resolutions;

  Future<void> getResolution(aimagId, page, {bool isForced = false}) async {
    if (isForced) {
      _resolutions = new List();
      _hasData = true;
    }

    _page = page;

    if (_hasData) {
      if (page == 1 && _resolutions.length > 0) {
        return;
      }
      List<Resolution> data = await api.getResolution(aimagId, page);
      if (data.length == 0) {
        _hasData = false;
      } else {
        _resolutions = _resolutions + data;
      }
    }
  }
}
