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

class TestGenre {
  String id;

  TestGenre(this.id);
}

List<TestGenre> genres = [
  TestGenre("All"),
  TestGenre("Action"),
  TestGenre("Fantasy"),
  TestGenre("Horor"),
  TestGenre("Drama"),
  TestGenre("Mystery"),
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
