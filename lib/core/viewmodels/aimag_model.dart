import 'base_model.dart';
import '../../locator.dart';
import 'package:youth/core/models/aimag.dart';
import 'package:youth/core/services/aimag_service.dart';

class AimagModel extends BaseModel {
  AimagService api = locator<AimagService>();
  List<Aimag> get nationalCouncilList => api.aimagList;

  Future<void> getAimagModelList() async {
    setLoading(true);
    await api.getAimags();
    setLoading(false);
  }
}