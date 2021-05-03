import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as secure;
import 'responseModel.dart';

BaseOptions options = new BaseOptions(
  headers: {
//    'Authorization': 'Bearer ' + prefs.getString("TOKEN"),
    "X-Requested-With": "XMLHttpRequest",
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded"
  },
  connectTimeout: 100000,
  receiveTimeout: 100000,
);

ResponseModel r = ResponseModel.fromError();

class NetworkUtil {
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  final storage = new secure.FlutterSecureStorage();

  factory NetworkUtil() => _instance;
  Dio dio = new Dio(options);
  Response response;

  initNetwork(baseUrl) {
    options.baseUrl = baseUrl;
  }

  Future<dynamic> get(String url, {dynamic params, String base}) async {
    if (base != null) {
      options.baseUrl = base;
    }

    try {
//      dio.interceptors.add(
//        InterceptorsWrapper(onRequest: (Options options) async {
//          String jwt = await storage.read(key: 'jwt');
//          options.headers["token"] = jwt;
//          return options;
//        }),
//      );

      response = await dio.get(url, queryParameters: params ?? null);
      print(response);
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
    }
    return response;
  }

  Future<dynamic> post(String url, body, {String base}) async {
    print(body);
    if (base != null) {
      options.baseUrl = base;
    }

    try {
//      dio.interceptors.add(
//        InterceptorsWrapper(onRequest: (Options options) async {
//          String jwt = await storage.read(key: 'jwt');
//          options.headers["token"] = jwt;
//          return options;
//        }),
//      );
      response = await dio.post(url, data: body);
      print(response);
      if (response.statusCode == 200) {
        r = ResponseModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      r = ResponseModel.fromError();
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
    }
    return r;
  }
}
