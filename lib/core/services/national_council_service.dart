import 'package:youth/core/models/national_council.dart';
import '../../locator.dart';
import 'api.dart';

class NationalCouncilService {
  Api api = locator<Api>();

  int _aimagId = 1;
  int _soumId = 1;

  int get aimagId => _aimagId;
  int get soumId => _soumId;

  bool _hasData = true;
  bool get hasData => _hasData;

  List<NationalCouncil> _allCouncils = new List();
  List<NationalCouncil> _councils = new List();
  List<NationalCouncil> get councilList => _councils;

  Future<void> getCouncils(aimagId, soumId, {bool isForced = false}) async {
    if (isForced) {
      _councils = new List();
      _allCouncils = new List();
      _hasData = true;
    }

    _aimagId = aimagId;
    _soumId = soumId;

    _councils = await api.getNationalCouncil(aimagId, soumId);
    //_allCouncils = await api.getNationalCouncil(aimagId, soumId);

    // if (_hasData) {
    //   List<NationalCouncil> data =
    //       await api.getNationalCouncil(aimagId, soumId);

    //   if (data.length == 0) {
    //     _hasData = false;
    //   }
    //   _councils = _allCouncils + data;
    // } else {
    //   List<NationalCouncil> data = await api.getNationalCouncil("", "");
    //   _councils = _allCouncils + data;
    // }
  }

  searchCouncil(String val) {
    _councils = _allCouncils;
    if (val != '' || val != null) {
      _councils = _councils.where((t) => t.name.contains(val)).toList();
    }
  }
}
