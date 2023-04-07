import 'dart:core';

import 'package:final_project/constants/asset_path.dart';

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";

class Movie {
  final String name, genre, synopsis, poster, banner;
  final int id, duration;
  final List casters;
  Movie(
      {required this.id,
      required this.name,
      required this.poster,
      required this.banner,
      required this.genre,
      required this.synopsis,
      required this.duration,
      required this.casters});
}

List<Movie> movies = [
  Movie(
      id: 1,
      name: "How to train you dragon 3",
      poster: AssetPath.posterDragon,
      banner: AssetPath.bannerDragon,
      genre: "Kids & family, Fantasy",
      synopsis: dummyText,
      duration: 124,
      casters: [
        {'nameCast': 'Reilly', 'imagePath': AssetPath.cast1},
        {'nameCast': 'McBrayer', 'imagePath': AssetPath.cast3}
      ]),
  Movie(
      id: 2,
      name: "Onward",
      poster: AssetPath.posterOnward,
      banner: AssetPath.bannerOnward,
      genre: "Fantasy, Adventure",
      synopsis: dummyText,
      duration: 111,
      casters: [
        {'nameCast': 'Gal Gadot', 'imagePath': AssetPath.cast2},
        {'nameCast': 'Silverman', 'imagePath': AssetPath.cast4},
        {'nameCast': 'Henson', 'imagePath': AssetPath.cast5}
      ]),
  Movie(
      id: 3,
      name: "Ralph",
      poster: AssetPath.posterRalph,
      banner: AssetPath.bannerRalph,
      genre: "Adventure, Comedy",
      synopsis: dummyText,
      duration: 98,
      casters: [
        {'nameCast': 'McBrayer', 'imagePath': AssetPath.cast3},
        {'nameCast': 'Henson', 'imagePath': AssetPath.cast5},
        {'nameCast': 'Reilly', 'imagePath': AssetPath.cast1},
        {'nameCast': 'Henson', 'imagePath': AssetPath.cast5}
      ]),
  Movie(
      id: 4,
      name: "Frozen",
      poster: AssetPath.posterFrozen,
      banner: AssetPath.bannerFrozen,
      genre: "Adventure, Comedy",
      synopsis: dummyText,
      duration: 98,
      casters: [
        {'nameCast': 'McBrayer', 'imagePath': AssetPath.cast3},
        {'nameCast': 'Henson', 'imagePath': AssetPath.cast5},
        {'nameCast': 'Reilly', 'imagePath': AssetPath.cast1},
        {'nameCast': 'Henson', 'imagePath': AssetPath.cast5}
      ]),
  Movie(
      id: 5,
      name: "Scoob",
      poster: AssetPath.posterScoob,
      banner: AssetPath.bannerScoob,
      genre: "Adventure, Comedy",
      synopsis: dummyText,
      duration: 98,
      casters: [
        {'nameCast': 'McBrayer', 'imagePath': AssetPath.cast3},
        {'nameCast': 'Henson', 'imagePath': AssetPath.cast5},
        {'nameCast': 'Reilly', 'imagePath': AssetPath.cast1},
        {'nameCast': 'Henson', 'imagePath': AssetPath.cast5}
      ]),
  Movie(
      id: 6,
      name: "Spongebob",
      poster: AssetPath.posterSpongebob,
      banner: AssetPath.bannerSpongebob,
      genre: "Adventure, Comedy",
      synopsis: dummyText,
      duration: 98,
      casters: [
        {'nameCast': 'McBrayer', 'imagePath': AssetPath.cast3},
        {'nameCast': 'Henson', 'imagePath': AssetPath.cast5},
        {'nameCast': 'Reilly', 'imagePath': AssetPath.cast1},
        {'nameCast': 'Henson', 'imagePath': AssetPath.cast5}
      ])
];

class Day {
  final int dd;
  final String day;
  Day({required this.dd, required this.day});
}

List<Day> days = [
  Day(dd: 7, day: "Fri"),
  Day(dd: 8, day: "Sat"),
  Day(dd: 9, day: "Sun"),
  Day(dd: 10, day: "Mon"),
  Day(dd: 11, day: "Tue"),
];

class Time {
  final String time;
  Time({required this.time});
}

List<Time> times = [
  Time(time: '13:00'),
  Time(time: '15:00'),
  Time(time: '17:30'),
  Time(time: '19:00'),
  Time(time: '22:00')
];

class TicketStates {
  final String state;
  TicketStates({required this.state});
}

List<TicketStates> dateStates = [
  TicketStates(state: 'idle'),
  TicketStates(state: 'busy'),
  TicketStates(state: 'idle'),
  TicketStates(state: 'idle'),
  TicketStates(state: 'idle')
];

class Genre {
  String id;

  Genre(this.id);
}

List<Genre> genres = [
  Genre("All"),
  Genre("Action"),
  Genre("Fantasy"),
  Genre("Horor"),
  Genre("Drama"),
  Genre("Mystery"),
];

class Trailer {
  String name;
  String imagePath;

  Trailer(this.name, this.imagePath);
}

List<Trailer> trailers = [
  Trailer("Trailer 1", AssetPath.trailer1),
  Trailer("Trailer 1", AssetPath.trailer2),
];
