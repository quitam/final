
class Genre
{
  String id;
  Genre({
    this.id = ''
  });

  static Genre fromJson(Map<String, dynamic> json) => Genre(
    id: json['id']
  );
}

