import 'dart:convert';

import 'package:youth/core/models/aimag.dart';
import 'package:youth/core/models/anime.dart';
import 'package:youth/core/models/branch.dart';
import 'package:youth/core/models/episode.dart';
import 'package:youth/core/models/faq.dart';
import 'package:youth/core/models/job.dart';
import 'package:youth/core/models/movie.dart';
import 'package:youth/core/models/national_council.dart';
import 'package:youth/core/models/staff.dart';
import 'package:youth/core/models/video.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:youth/core/models/slide.dart';

class Api {
  NetworkUtil _http = new NetworkUtil();

  //faq api
  Future<List<Faq>> getFaq() async {
    var data = new List<Faq>();
    final response = await _http.get('/api/m/faq');
    var parsed = response.data as List<dynamic>;

    for (var f in parsed) {
      data.add(Faq.fromJson(f));
    }
    return data;
  }

  //slide api
  Future<List<Slide>> getSlides() async {
    var data = List<Slide>();
    var response = await _http.get('/api/m/slides');
    var parsed = response.data as List<dynamic>;

    for (var item in parsed) {
      data.add(Slide.fromJson(item));
    }
    return data;
  }

  //episode api home
  Future<List<Episode>> getHomeEpisodes() async {
    var data = List<Episode>();
    var response = await _http.get('/api/m/latest/anime');
    var parsed = response.data as List<dynamic>;

    for (var item in parsed) {
      data.add(Episode.fromJson(item));
    }

    return data;
  }

  //get movies home
  Future<List<Movie>> getHomeMovies() async {
    var data = List<Movie>();
    var response = await _http.get('/api/m/latest/movie');
    var parsed = response.data as List<dynamic>;

    for (var item in parsed) {
      data.add(Movie.fromJson(item));
    }

    return data;
  }

  //get videos home
  Future<List<Video>> getHomeVideos() async {
    var data = List<Video>();
    var response = await _http.get('/api/m/latest/video');
    var parsed = response.data as List<dynamic>;

    for (var item in parsed) {
      data.add(Video.fromJson(item));
    }

    return data;
  }

  //get anime
  Future<List<Anime>> getAnimes(int page) async {
    var data = List<Anime>();
    var response = await _http.get('/api/m/anime?page=${page}');
    var parsed = response.data['data'] as List<dynamic>;

    for (var anime in parsed) {
      data.add(Anime.fromJson(anime));
    }
    return data;
  }

  //get anime by season
  Future<List<Anime>> getAnimebySeason(page) async {
    var data = List<Anime>();
    var response = await _http.get('/api/m/anime/season?page=${page}');
    var parsed = response.data['data'] as List<dynamic>;

    for (var anime in parsed) {
      data.add(Anime.fromJson(anime));
    }

    return data;
  }

  //get anime by view
  Future<List<Anime>> getAnimeByView(page) async {
    var data = List<Anime>();
    var response = await _http.get('/api/m/anime/view?page=${page}');
    var parsed = response.data['data'] as List<dynamic>;

    for (var anime in parsed) {
      data.add(Anime.fromJson(anime));
    }
    return data;
  }

  // Movie page
  Future<List<Movie>> getMovieList(page) async {
    var data = List<Movie>();
    var response = await _http.get('/api/m/movies?page=${page}');
    var parsed = response.data['data'] as List<dynamic>;

    for (var item in parsed) {
      data.add(Movie.fromJson(item));
    }
    return data;
  }

  //Video page
  Future<List<Video>> getVideoList(page, {bool isForced = false}) async {
    var data = List<Video>();
    var response = await _http.get('/api/m/videos?page=${page}');
    var parsed = response.data['data'] as List<dynamic>;

    for (var item in parsed) {
      data.add(Video.fromJson(item));
    }

    return data;
  }

  Future<List<Episode>> getNewEpisodes(int page) async {
    var data = List<Episode>();

    final response = await _http.get('/api/m/new?page=${page}');
    var parsed = response.data['data'] as List<dynamic>;

    for (var item in parsed) {
      data.add(Episode.fromJson(item));
    }
    return data;
  }

  Future<List<Branch>> getBranches() async {
    var data = List<Branch>();
    var response = await _http.get('/api/m/branches');
    var parsed = response.data as List<dynamic>;

    for (var item in parsed) {
      data.add(Branch.fromJson(item));
    }
    return data;
  }

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

  Future<List<NationalCouncil>> getNationalCouncil() async {
    var data = new List<NationalCouncil>();
    final response = await _http.postRaw('/api/mobile/zxvz', {
      "search": "",
      "aimag": "",
      "soum": "",
    });

    var parsed = response.data as List<dynamic>;

    for (var d in parsed) {
      data.add(NationalCouncil.fromJson(d));
    }
    return data;
  }

  Future<List<NationalCouncil>> getNationalCouncilDetail() async {
    var data = new List<NationalCouncil>();
    final response = await _http.getRaw('/api/mobile/get-council-detail/5');

    var parsed = response.data as List<dynamic>;

    for (var d in parsed) {
      data.add(NationalCouncil.fromJson(d));
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

  Future<List<Staff>> getStaffList() async {
    var data = new List<Staff>();

    final response = await _http.getRaw('/api/mobile/get-member-list/5');
    var parsed = response.data as List<dynamic>;

    for (var item in parsed) {
      data.add(Staff.fromJson(item));
    }

    return data;
  }
}
