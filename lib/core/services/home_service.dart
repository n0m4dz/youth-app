import 'package:youth/core/models/episode.dart';
import 'package:youth/core/models/movie.dart';
import 'package:youth/core/models/slide.dart';
import 'package:youth/core/models/video.dart';

import '../../locator.dart';
import 'api.dart';

class HomeService {
  Api api = locator<Api>();

  List<Episode> _episodes = new List();
  List<Episode> get episodeList => _episodes;

  List<Movie> _movies = new List();
  List<Movie> get movieList => _movies;

  List<Video> _videos = new List();
  List<Video> get videoList => _videos;

  List<Slide> _slides;
  List<Slide> get slideList => _slides;

  Future<void> getSlides() async {
    _slides = await api.getSlides();
  }

  getEpisodes() async {
    _episodes = await api.getHomeEpisodes();
  }

  getMovies() async {
    _movies = await api.getHomeMovies();
  }

  Future<void> getVideos() async {
    _videos = await api.getHomeVideos();
  }
}
