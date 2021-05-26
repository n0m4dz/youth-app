import 'package:youth/core/models/youth_council.dart';
import '../../locator.dart';
import 'api.dart';

class YouthCouncilService {
  Api api = locator<Api>();

  int _aimagId = 1;
  int _soumId = 1;
  int _bkhId = 1;

  int get aimagId => _aimagId;
  int get soumId => _soumId;
  int get bkhId => _bkhId;

  bool _hasData = false;
  bool get hasData => _hasData;

  List<YouthCouncil> _allYouthCounchils = new List();
  List<YouthCouncil> _youthCounchils = new List();

  List<YouthCouncil> get youthCouncilList => _youthCounchils;

  Future<void> getYouthCouncil(aimagId, soumId, bkhId,
      {bool isForced = false}) async {
    if (isForced) {
      _youthCounchils = new List();
      _hasData = true;
    }

    _aimagId = aimagId;
    _soumId = soumId;
    _bkhId = bkhId;

    _youthCounchils = await api.getYouthCouncil(aimagId, soumId, bkhId);
    _allYouthCounchils = await api.getYouthCouncil(aimagId, soumId, bkhId);

    if (isForced) {
      List<YouthCouncil> data =
          await api.getYouthCouncil(aimagId, soumId, bkhId);

      _youthCounchils = _youthCounchils + data;
    } else {
      List<YouthCouncil> data = await api.getYouthCouncil(null, null, null);
      _youthCounchils = _youthCounchils + data;
    }
  }

  searchCouncil(String val) {
    _youthCounchils = _allYouthCounchils;
    if (val != '' || val != null) {
      _youthCounchils = _youthCounchils
          .where((c) => c.name.toLowerCase().contains(val))
          .toList();
    }
  }
}
