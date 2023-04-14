class Genre {
  String id;
  String displayName;
  Genre({this.id = "", this.displayName = ""});

  static Genre fromJson(Map<String, dynamic> json) =>
      Genre(id: json['id'], displayName: json["display_name"]);
}

class Movie {
  String id;
  String name ;
  String bannerUrl;
  String posterUrl;
  int duration;
  List<String> genres;
  String synopsis;
  String trailer;

  Movie({
    required this.id,
    required this.name,
    required this.bannerUrl,
    required this.posterUrl,
    required this.duration,
    required this.genres,
    required this.synopsis, 
    required this.trailer
  });

  static Movie fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'],
        name: json["name"],
        bannerUrl: json["banner_image"],
        posterUrl: json["poster_image"],
        duration: json["duration"],
        genres: List<String>.from(json["genres"]),
        synopsis: json["synopsis"],
        trailer: json["trailer"]
        // releaseDate:
        //     DateTime.fromMillisecondsSinceEpoch(json['release_date'] * 1000)
        //genres: json["genres"].toList().map((dynamic element) => element.toString()).toList(),
      );
}

class Actor
{
  String id;
  String name;
  String image;

  Actor({
    required this.id,
    required this.name, 
    required this.image
  });

  static Actor fromJson(Map<String, dynamic> json) => Actor(
      id: json["id"], 
      name: json["name"], 
      image: json["image"]
    );
}

class MovieActor
{
  String id;
  String actor;
  String movie;
  String role;

  MovieActor({
    required this.id,
    required this.actor,
    required this.movie,
    required this.role
  });

   static MovieActor fromJson(Map<String, dynamic> json) => MovieActor(
      id: json["id"], 
      actor: json["actor"], 
      movie: json["movie"],
      role: json["role"]
    );
}