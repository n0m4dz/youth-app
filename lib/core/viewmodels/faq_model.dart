import 'package:youth/core/models/faq.dart';
import 'package:youth/core/services/api.dart';
import 'package:youth/core/services/faq_service.dart';
import 'package:meta/meta.dart';

import '../../locator.dart';
import 'base_model.dart';

class FaqModel extends BaseModel {
  FaqService api = locator<FaqService>();

  List<Faq> get faqList => api.faqList;

  Future getFaqs([bool force = false]) async {
    setLoading(true);
    await api.getFaq();
    setLoading(false);
  }
}
