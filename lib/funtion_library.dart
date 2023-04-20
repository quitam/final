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

Future<List<Actor>> getActorOfMovie(String movieId) async
{
  CollectionReference actorCollection = FirebaseFirestore.instance.collection("Actor");
  CollectionReference movieActorCollection = FirebaseFirestore.instance.collection("Movie_Actor");

  QuerySnapshot actorQuerySnapshots = await actorCollection.get();
  QuerySnapshot movieActorQuerySnapshots = await movieActorCollection.where("movie", isEqualTo: movieId).get();

  List<MovieActor> movieActors = movieActorQuerySnapshots.docs.map((e) => MovieActor.fromJson(e.data() as Map<String, dynamic>)).toList();
  List<Actor> actors = actorQuerySnapshots.docs.map((e) => Actor.fromJson(e.data() as Map<String, dynamic>)).toList(); 

  List<Actor> actorsInMovie = [];
  if(movieActors.isNotEmpty && actors.isNotEmpty)
  {
    for(Actor actor in actors)
    {
      if(checkActorInMovieActorList(actor, movieActors))
      {
        actorsInMovie.add(actor);
      }
    }
  }
  return actorsInMovie;
}

Future<List<String>> getAllMovieNames() async
{
  List<String> movieNames = [];
  CollectionReference movieCollectionReference = FirebaseFirestore.instance.collection("Movie");
  QuerySnapshot movieSnapshots = await movieCollectionReference.get();
  List<Movie> movies = movieSnapshots.docs.map((e) => Movie.fromJson(e.data() as Map<String, dynamic>)).toList();
  for(Movie tempMovie in movies)
  {
    movieNames.add(tempMovie.name);
  }
  return movieNames;
}

bool checkActorInMovieActorList(Actor actor, List<MovieActor> movieActors)
{
  if (movieActors.isEmpty) return false;
  for(MovieActor movieActor in movieActors)
  {
    if (movieActor.actor == actor.id) return true;
  }
  return false;
}

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
          return const SizedBox(
              height: 100, width: 100, child: CircularProgressIndicator());
        }
        String url = snapshot.data ?? "default";
        return Image.network(url);
      },
    );
  }
}
