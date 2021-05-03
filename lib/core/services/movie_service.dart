import 'package:youth/core/models/movie.dart';
import '../../locator.dart';
import 'api.dart';

class MovieService {
  Api api = locator<Api>();

  List<Movie> _movies = new List();
  List<Movie> get movieList => _movies;

  bool _hasData = true;
  bool get hasData => _hasData;

  Future<void> getMovieList(page, {bool isForced = false}) async {
    if (isForced) {
      _movies = new List();
      _hasData = true;
    }

    if (_hasData) {
      List<Movie> data = await api.getMovieList(page);
      if (data.length == 0) {
        _hasData = false;
      } else {
        _movies += data;
      }
    }
  }
}
