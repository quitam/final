import 'package:final_project/constants/asset_path.dart';

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

class Movie {
  String name;
  String imagePath;

  Movie(this.name, this.imagePath);
}

List<Movie> movies = [
  Movie("How to train you dragon 3", AssetPath.banner1),
  Movie("Onward", AssetPath.banner2),
  Movie("Ralph", AssetPath.banner3),
];

class Coming {
  String imagePath;

  Coming(this.imagePath);
}

List<Coming> comings = [
  Coming(AssetPath.posterRalph),
  Coming(AssetPath.posterDragon),
  Coming(AssetPath.posterFrozen),
  Coming(AssetPath.posterOnward),
  Coming(AssetPath.posterScoob),
  Coming(AssetPath.posterSpongebob),
];

class Cast {
  String name;
  String imagePath;

  Cast(this.name, this.imagePath);
}

List<Cast> casters = [
  Cast("Reilly", AssetPath.cast1),
  Cast("Gal Gadot", AssetPath.cast2),
  Cast("McBrayer", AssetPath.cast3),
  Cast("Silverman", AssetPath.cast4),
  Cast("Henson", AssetPath.cast5),
];
