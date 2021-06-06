import 'dart:convert';

import 'package:youth/core/models/event.dart';
import 'package:youth/core/models/bag_khoroo.dart';
import 'package:youth/core/models/law.dart';
import 'package:youth/core/models/soum.dart';
import 'package:youth/core/models/aimag.dart';
import 'package:youth/core/models/aimag_news.dart';
import 'package:youth/core/models/anime.dart';
import 'package:youth/core/models/branch.dart';
import 'package:youth/core/models/episode.dart';
import 'package:youth/core/models/job.dart';
import 'package:youth/core/models/movie.dart';
import 'package:youth/core/models/national_council.dart';
import 'package:youth/core/models/youth_council.dart';
import 'package:youth/core/models/resolution.dart';
import 'package:youth/core/models/staff.dart';
import 'package:youth/core/models/video.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:youth/core/models/slide.dart';
import 'package:youth/core/models/volunteer_work.dart';

class Api {
  NetworkUtil _http = new NetworkUtil();

  Future<String> getPaymentInfo() async {
    var response = await _http.get('/api/m/payment');
    return response.data["body"];
  }

  //Hentai
  Future<List<Anime>> getHentaiAnimes(int page) async {
    var data = List<Anime>();
    var response = await _http.get('/api/m/hentai?page=${page}');
    var parsed = response.data['data'] as List<dynamic>;

    for (var anime in parsed) {
      data.add(Anime.fromJson(anime));
    }
    return data;
  }

  Future<List<Episode>> getHentaiEpisodes(int page) async {
    var data = List<Episode>();

    final response = await _http.get('/api/m/hentai/episodes?page=${page}');
    var parsed = response.data['data'] as List<dynamic>;

    for (var item in parsed) {
      data.add(Episode.fromJson(item));
    }
    return data;
  }

  //Job
  List<Job> _job = new List();
  List<Job> get jobList => _job;

  Future<void> getJobList() async {
    _job = new List();

    final response = await _http.get('/mobile/api/getJobs/null');
    var parsed = response.data['data'] as List<dynamic>;

    for (var item in parsed) {
      _job.add(Job.fromJson(item));
    }
  }

  /* NB */

  Future<List<NationalCouncil>> getNationalCouncil(aimagId, soumId) async {
    var data = new List<NationalCouncil>();
    final response = await _http.postRaw('/api/mobile/zxvz', {
      "search": "",
      "aimag": aimagId,
      "soum": soumId,
    });

    var parsed = response.data as List<dynamic>;

    for (var d in parsed) {
      data.add(NationalCouncil.fromJson(d));
    }
    return data;
  }

  Future<List<YouthCouncil>> getYouthCouncil(
      page, aimagId, soumId, bkhId) async {
    print('<-------------------------------------------->');
    print(page);
    print('<-------------------------------------------->');
    var data = new List<YouthCouncil>();
    final response = await _http.post('/api/mobile/zxz?page=' + page.toString(),
        {"search": "", "aimag": aimagId, "soum": soumId, "bag-khoroo": bkhId});

    var parsed = response.data as List<dynamic>;

    for (var y in parsed) {
      data.add(YouthCouncil.fromJson(y));
    }
    return data;
  }

  Future<List<Aimag>> getAimagList() async {
    var data = new List<Aimag>();

    final response = await _http.getRaw('/api/mobile/aimag');
    var parsed = response.data as List<dynamic>;

    for (var item in parsed) {
      data.add(Aimag.fromJson(item));
    }

    return data;
  }

  Future<List<Soum>> getSoumList(int aimagId) async {
    var data = new List<Soum>();

    final response =
        await _http.getRaw('/api/mobile/soum/' + aimagId.toString());
    var parsed = response.data as List<dynamic>;

    for (var item in parsed) {
      data.add(Soum.fromJson(item));
    }

    return data;
  }

  Future<List<BagKhoroo>> getBagKhorooList(int soumId) async {
    var data = new List<BagKhoroo>();

    final response =
        await _http.getRaw('/api/mobile/bag-khoroo/' + soumId.toString());
    var parsed = response.data as List<dynamic>;

    for (var b in parsed) {
      data.add(BagKhoroo.fromJson(b));
    }

    return data;
  }

  Future<List<Staff>> getStaffList(aimagId) async {
    var data = new List<Staff>();

    final response =
        await _http.getRaw('/api/mobile/get-member-list/' + aimagId.toString());
    var parsed = response.data as List<dynamic>;

    for (var item in parsed) {
      data.add(Staff.fromJson(item));
    }

    return data;
  }

  Future<List<AimagNews>> getAimagNews(int aimagId, int page) async {
    var data = new List<AimagNews>();

    final response = await _http.get('/api/mobile/get-news/' +
        aimagId.toString() +
        "?page=" +
        page.toString());
    var parsed = response.data['data'] as List<dynamic>;

    for (var news in parsed) {
      data.add(AimagNews.fromJson(news));
    }

    return data;
  }

  Future<List<Resolution>> getData(int aimagId, int type, int page) async {
    var data = new List<Resolution>();

    final response = await _http.getRaw('/api/mobile/get-legals/' +
        aimagId.toString() +
        '/' +
        type.toString() +
        '?page=' +
        page.toString());

    var parsed = response.data['data'] as List<dynamic>;

    for (var r in parsed) {
      data.add(Resolution.fromJson(r));
    }

    return data;
  }

  Future<List<VolunteerWork>> getVolunteerWorks(int aimagId, int page) async {
    var data = new List<VolunteerWork>();

    final response = await _http.get('/api/mobile/get-volunteers/' +
        aimagId.toString() +
        '?page=' +
        page.toString());

    var parsed = response.data['volunteers']['data'] as List<dynamic>;

    for (var r in parsed) {
      data.add(VolunteerWork.fromJson(r));
    }

    return data;
  }

  Future<List<Event>> getApiEvents(int aimagId, int page) async {
    var data = new List<Event>();

    final response = await _http.get('/api/mobile/get-events/' +
        aimagId.toString() +
        '?page=' +
        page.toString());

    var parsed = response.data['data'] as List<dynamic>;

    for (var r in parsed) {
      data.add(Event.fromJson(r));
    }

    return data;
  }

  Future<List<Law>> getApiLaws(int page) async {
    var data = new List<Law>();

    final response =
        await _http.get('/api/mobile/getLegals?page=' + page.toString());

    print('-------------------------------------------');
    print(response.data['data']['data']);
    print('-------------------------------------------');

    var parsed = response.data['data']['data'] as List<dynamic>;

    for (var r in parsed) {
      data.add(Law.fromJson(r));
    }

    return data;
  }
}
