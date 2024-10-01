import 'package:catalog/model/movie.dart';
import 'package:get/get.dart';

class Moviescontroller extends GetxController {
  List<Movie> movies = [];

  void clearItems() {
    try {
      movies.clear();
      update(["listOfMovies"]);
    } catch (exception) {
      exception.toString();
    }
  }

  void addMovie(Movie movie) {
    try {
      movies.add(movie);
      update(["listOfMovies"]);
    } catch (exception) {
      exception.toString();
    }

  }

  void removeMovie(Movie movieDelete) {
    try {
      movies.remove(movieDelete);
      update(["listOfMovies"]);
    } catch (exception) {
      exception.toString();
    }
  }

  void editMovie(Movie oldMovie, Movie newMovie) {
    
    try {
      final index = movies.indexWhere((movie) => movie.name == oldMovie.name);

      if (index != -1) {
      movies[index] = newMovie;
      update(["listOfMovies"]); 
    }
    
    } catch (exception) {
      exception.toString();
    }
    
  }
}
