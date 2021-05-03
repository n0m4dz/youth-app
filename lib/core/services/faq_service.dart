import 'package:youth/core/models/faq.dart';
import '../../locator.dart';
import 'api.dart';

class FaqService {
  Api api = locator<Api>();

  List<Faq> _faqs = new List();
  List<Faq> get faqList => _faqs;

  getFaq() async {
    _faqs = await api.getFaq();
  }
}
