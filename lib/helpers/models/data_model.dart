class Movie {
  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String awards;
  final String poster;
  final String ratings;
  final String metascore;
  final String imdbRating;
  final String imdbVotes;
  final String imdbID;
  final String type;
 
  
  final List<Season>? seasons; // For series only

  Movie({
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.poster,
    required this.ratings,
    required this.metascore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.imdbID,
    required this.type,
   
    this.seasons, // For series only
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    // If the type is series, parse the seasons
    List<Season>? seasonsList;
    if (json['type'] == 'series' && json['seasons'] != null) {
      seasonsList = List<Season>.from(json['seasons'].map((season) => Season.fromJson(season)));
    }

    return Movie(
      title: json['Title'],
      year: json['Year'],
      rated: json['Rated'],
      released: json['Released'],
      runtime: json['Runtime'],
      genre: json['Genre'],
      director: json['Director'],
      writer: json['Writer'],
      actors: json['Actors'],
      plot: json['Plot'],
      language: json['Language'],
      country: json['Country'],
      awards: json['Awards'],
      poster: json['Poster'],
      ratings: json['Ratings'],
      metascore: json['Metascore'],
      imdbRating: json['imdbRating'],
      imdbVotes: json['imdbVotes'],
      imdbID: json['imdbID'],
      type: json['Type'],
     
      seasons: seasonsList, // For series only
    );
  }
}

class Season {
  final String seasonNumber;
  final List<Episode> episodes;

  Season({
    required this.seasonNumber,
    required this.episodes,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    List<dynamic> episodesData = json['episodes'];
    List<Episode> episodesList = episodesData.map((episode) => Episode.fromJson(episode)).toList();

    return Season(
      seasonNumber: json['season_number'],
      episodes: episodesList,
    );
  }
}

class Episode {
  final String episodeNumber;
  final String episodeTitle;
  final String downloadLink;
  final String playLink;

  Episode({
    required this.episodeNumber,
    required this.episodeTitle,
    required this.downloadLink,
    required this.playLink,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      episodeNumber: json['episode_number'],
      episodeTitle: json['episode_title'],
      downloadLink: json['download_link'],
      playLink: json['play_link'],
    );
  }
}