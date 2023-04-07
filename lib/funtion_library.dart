import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'models/models.dart';

Future<String> getImageUrl(String imagePath) async {
  Reference ref = FirebaseStorage.instance.ref().child(imagePath);
  return await ref.getDownloadURL();
}

Stream<List<Genre>> getGenres() =>
    FirebaseFirestore.instance.collection("Genre").snapshots().map((snapshot) =>
        snapshot.docs.map((e) => Genre.fromJson(e.data())).toList());

Stream<List<Movie>> getMoviess() =>
    FirebaseFirestore.instance.collection("Movie").snapshots().map((snapshot) =>
        snapshot.docs.map((e) => Movie.fromJson(e.data())).toList());

Stream<List<Movie>> getPlayingMovies() => FirebaseFirestore.instance
    .collection("Movie")
    .where("release_date", isLessThanOrEqualTo: DateTime.now())
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((e) => Movie.fromJson(e.data())).toList());

Stream<List<Movie>> getUpComingMovies() => FirebaseFirestore.instance
    .collection("Movie")
    .where("release_date", isGreaterThan: DateTime.now())
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((e) => Movie.fromJson(e.data())).toList());

class ImageFromUrl extends StatelessWidget {
  final String imageUrl;
  const ImageFromUrl({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseStorage.instance.ref(imageUrl).getDownloadURL(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        String url = snapshot.data ?? "default";
        return Image.network(url);
      },
    );
  }
}
