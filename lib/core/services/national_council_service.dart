import 'package:youth/core/models/national_council.dart';
import '../../locator.dart';
import 'api.dart';

class NationalCouncilService {
  Api api = locator<Api>();

  List<NationalCouncil> _councils = new List();
  List<NationalCouncil> get councilList => _councils;

  getCouncils() async {
    _councils = await api.getNationalCouncil();
  }
}
