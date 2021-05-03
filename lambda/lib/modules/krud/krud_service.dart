import '../network_util.dart';

class KrudService {
  NetworkUtil _http = new NetworkUtil();

  Future<void> krudList(String url, dynamic model) async {
    var data = new List<dynamic>();
    final response = await _http.get(url);
    var parsed = response.data['data'] as List<dynamic>;

    for (var f in parsed) {
//      data.add(new model.fromJson(f));
    }

    return data;
  }

  Future<void> krudSingle(String url) {}
}
