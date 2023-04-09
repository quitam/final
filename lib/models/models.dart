class Genre {
  String id;
  String displayName;
  Genre({this.id = "", this.displayName = ""});

  static Genre fromJson(Map<String, dynamic> json) =>
      Genre(id: json['id'], displayName: json["display_name"]);
}

class Movie {
  String id;
  String name;
  String bannerUrl;
  String posterUrl;
  int duration;
  List<String> genres;

  Movie({
    required this.id,
    required this.name,
    required this.bannerUrl,
    required this.posterUrl,
    required this.duration,
    required this.genres,
  });

  static Movie fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'],
        name: json["name"],
        bannerUrl: json["banner_image"],
        posterUrl: json["poster_image"],
        duration: json["duration"],
        genres: List<String>.from(json["genres"]),
        // releaseDate:
        //     DateTime.fromMillisecondsSinceEpoch(json['release_date'] * 1000)
        //genres: json["genres"].toList().map((dynamic element) => element.toString()).toList(),
      );
}
