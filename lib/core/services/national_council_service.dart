import 'package:youth/core/models/national_council.dart';
import '../../locator.dart';
import 'api.dart';

class NationalCouncilService {
  Api api = locator<Api>();
  List<NationalCouncil> _allCouncils = new List();
  List<NationalCouncil> _councils = new List();
  List<NationalCouncil> get councilList => _councils;

  Future<void> getCouncils(search) async {
    _councils = await api.getNationalCouncil(search);
    _allCouncils = await api.getNationalCouncil(search);
    List<NationalCouncil> data = await api.getNationalCouncil(search);
    if (data.length > 0) {
      _councils = _councils + data;
    }
  }

  searchTrack(String val) {
    _councils = _allCouncils;
    if (val != '' || val != null) {
      _councils = _councils.where((t) => t.name.contains(val)).toList();
    }
  }
}
