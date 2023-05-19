
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
  DateTime releaseDate;

  Movie({
    required this.id,
    required this.name,
    required this.bannerUrl,
    required this.posterUrl,
    required this.duration,
    required this.genres,
    required this.synopsis, 
    required this.trailer,
    required this.releaseDate
  });

  static Movie fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'],
        name: json["name"],
        bannerUrl: json["banner_image"],
        posterUrl: json["poster_image"],
        duration: json["duration"],
        genres: List<String>.from(json["genres"]),
        synopsis: json["synopsis"],
        trailer: json["trailer"],
        releaseDate: json["release_date"].toDate()
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

class Screening
{
  String id;
  String theaterId;
  String filmId;
  DateTime endTime;
  DateTime startTime;
  int price;

  Screening({
    required this.id,
    required this.theaterId,
    required this.filmId,
    required this.endTime,
    required this.startTime,
    required this.price,
  });

  static Screening fromJson(Map<String, dynamic> json) => Screening(
    id: json["id"],
    theaterId: json["theater"],
    filmId: json["film"],
    endTime: json["end_time"].toDate(),
    startTime: json["start_time"].toDate(),
    price: json["price"],
  );
}

class Theater
{
  String id;
  String groupId;
  String name;
  String address;
  int seatRows;
  int seatColumns;

  Theater({
    required this.id,
    required this.groupId,
    required this.name,
    required this.address,
    required this.seatRows,
    required this.seatColumns
  });

   static Theater fromJson(Map<String, dynamic> json) => Theater(
    id: json["id"],
    groupId: json["group_id"],
    name: json["name"],
    address: json["address"],
    seatRows: json["rows"],
    seatColumns: json["columns"]
  );
}

class Ticket
{
  String id;
  String screeningId;
  String userId;
  String seat;

  Ticket({
    required this.id,
    required this.screeningId,
    required this.userId,
    required this.seat,
  });

  static Ticket fromJson(Map<String, dynamic> json) => Ticket(
    id: json["id"],
    screeningId: json["screening"],
    userId: json["user"],
    seat: json["seat"], 
  );
}
