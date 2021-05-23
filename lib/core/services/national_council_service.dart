import 'package:youth/core/models/national_council.dart';
import '../../locator.dart';
import 'api.dart';

class NationalCouncilService {
  Api api = locator<Api>();

  List<NationalCouncil> _councils = new List();
  List<NationalCouncil> get councilList => _councils;

  getCouncils(search, {bool isForced = false}) async {
    if (isForced) {
      _councils = new List();
    }

    _councils = await api.getNationalCouncil(search);
    List<NationalCouncil> data = await api.getNationalCouncil(search);
    if (data.length > 0) {
      _councils = _councils + data;
    }
  }
}
